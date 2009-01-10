From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/4] Make hash table scale to
	thousands	of	entries
Date: Sat, 10 Jan 2009 12:57:07 +0900
Message-ID: <1231559827.3047.77.camel@zeus.themaw.net>
References: <1231526823-18595-1-git-send-email-vaurora@redhat.com>
	<1231526823-18595-2-git-send-email-vaurora@redhat.com>
	<1231558167.3047.70.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1231558167.3047.70.camel@zeus.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Valerie Aurora Henson <vaurora@redhat.com>
Cc: autofs@linux.kernel.org

On Sat, 2009-01-10 at 12:29 +0900, Ian Kent wrote:
> On Fri, 2009-01-09 at 13:47 -0500, Valerie Aurora Henson wrote:
> > From: Paul Wankadia <junyer@google.com>
> > Signed-off-by: Valerie Aurora Henson <vaurora@redhat.com>
> 
> Perhaps this will help with the description.
> 
> What I think is the main point of this patch is that, with the trivial
> hash function, the length of the chains aren't evenly spread causing
> some chains to be excessively long for large maps. And the size of the
> hash table is too small because for 10000 entries we would have chains
> of about 130 entries if they were in fact spread evenly, and the claim
> is that they aren't.

And, yes, we should also be able to do much better than chain lengths of
around 130.

A simple minded check would be to modify the cache_dump_cache() function
to report chain lengths, add a call to it in a couple of strategic
places and construct a test to load a large map. The difficulty, of
course, is to ensure we are using strings with a distribution of
characters that are really representative of map keys.

> 
> > ---
> >  include/automount.h |    2 +-
> >  lib/cache.c         |   29 ++++++++++++++++++-----------
> >  2 files changed, 19 insertions(+), 12 deletions(-)
> > 
> > diff --git a/include/automount.h b/include/automount.h
> > index 1ba0d3c..2a082b5 100644
> > --- a/include/automount.h
> > +++ b/include/automount.h
> > @@ -126,7 +126,7 @@ struct autofs_point;
> >  #define CHE_DUPLICATE	0x0020
> >  #define CHE_UNAVAIL	0x0040
> >  
> > -#define HASHSIZE		77
> > +#define HASHSIZE		4096
> >  #define NEGATIVE_TIMEOUT	10
> >  #define UMOUNT_RETRIES		8
> >  #define EXPIRE_RETRIES		3
> > diff --git a/lib/cache.c b/lib/cache.c
> > index ce47e04..36b8294 100644
> > --- a/lib/cache.c
> > +++ b/lib/cache.c
> > @@ -281,20 +281,27 @@ struct mapent_cache *cache_init_null_cache(struct master *master)
> >  	return mc;
> >  }
> >  
> > -static unsigned int hash(const char *key)
> > +static u_int32_t hash(const char *key)
> >  {
> > -	unsigned long hashval;
> > +	u_int32_t hashval;
> >  	char *s = (char *) key;
> >  
> > -	for (hashval = 0; *s != '\0';)
> > -		hashval += *s++;
> > +	for (hashval = 0; *s != '\0';) {
> > +		hashval += (unsigned char) *s++;
> > +		hashval += (hashval << 10);
> > +		hashval ^= (hashval >> 6);
> > +	}
> > +
> > +	hashval += (hashval << 3);
> > +	hashval ^= (hashval >> 11);
> > +	hashval += (hashval << 15);
> >  
> >  	return hashval % HASHSIZE;
> >  }
> >  
> > -static unsigned int ino_hash(dev_t dev, ino_t ino)
> > +static u_int32_t ino_hash(dev_t dev, ino_t ino)
> >  {
> > -	unsigned long hashval;
> > +	u_int32_t hashval;
> >  
> >  	hashval = dev + ino;
> >  
> > @@ -303,7 +310,7 @@ static unsigned int ino_hash(dev_t dev, ino_t ino)
> >  
> >  int cache_set_ino_index(struct mapent_cache *mc, const char *key, dev_t dev, ino_t ino)
> >  {
> > -	unsigned int ino_index = ino_hash(dev, ino);
> > +	u_int32_t ino_index = ino_hash(dev, ino);
> >  	struct mapent *me;
> >  
> >  	me = cache_lookup_distinct(mc, key);
> > @@ -325,7 +332,7 @@ struct mapent *cache_lookup_ino(struct mapent_cache *mc, dev_t dev, ino_t ino)
> >  {
> >  	struct mapent *me = NULL;
> >  	struct list_head *head, *p;
> > -	unsigned int ino_index;
> > +	u_int32_t ino_index;
> >  
> >  	ino_index_lock(mc);
> >  	ino_index = ino_hash(dev, ino);
> > @@ -371,7 +378,7 @@ struct mapent *cache_lookup_first(struct mapent_cache *mc)
> >  struct mapent *cache_lookup_next(struct mapent_cache *mc, struct mapent *me)
> >  {
> >  	struct mapent *this;
> > -	unsigned long hashval;
> > +	u_int32_t hashval;
> >  	unsigned int i;
> >  
> >  	if (!me)
> > @@ -532,7 +539,7 @@ int cache_add(struct mapent_cache *mc, struct map_source *ms, const char *key, c
> >  {
> >  	struct mapent *me, *existing = NULL;
> >  	char *pkey, *pent;
> > -	unsigned int hashval = hash(key);
> > +	u_int32_t hashval = hash(key);
> >  	int status;
> >  
> >  	me = (struct mapent *) malloc(sizeof(struct mapent));
> > @@ -752,7 +759,7 @@ int cache_update(struct mapent_cache *mc, struct map_source *ms, const char *key
> >  int cache_delete(struct mapent_cache *mc, const char *key)
> >  {
> >  	struct mapent *me = NULL, *pred;
> > -	unsigned int hashval = hash(key);
> > +	u_int32_t hashval = hash(key);
> >  	int status, ret = CHE_OK;
> >  	char *this;
> >  
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
