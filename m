From: Valerie Aurora Henson <vaurora@redhat.com>
Subject: Re: [PATCH 3/4] Easy alloca() replacements
Date: Fri, 16 Jan 2009 17:11:19 -0500
Message-ID: <20090116221119.GH6607@shell>
References: <1231526823-18595-1-git-send-email-vaurora@redhat.com>
	<1231526823-18595-2-git-send-email-vaurora@redhat.com>
	<1231526823-18595-3-git-send-email-vaurora@redhat.com>
	<1231526823-18595-4-git-send-email-vaurora@redhat.com>
	<1231557516.3047.61.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <1231557516.3047.61.camel@zeus.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On Sat, Jan 10, 2009 at 12:18:36PM +0900, Ian Kent wrote:
> On Fri, 2009-01-09 at 13:47 -0500, Valerie Aurora Henson wrote:
> 
> Just a first pass reading but noticed ....
> 
> > diff --git a/lib/cache.c b/lib/cache.c
> > index 36b8294..bc2c722 100644
> > --- a/lib/cache.c
> > +++ b/lib/cache.c
> > @@ -484,27 +484,19 @@ struct mapent *cache_lookup_offset(const char *prefix, const char *offset, int s
> >  {
> >  	struct list_head *p;
> >  	struct mapent *this;
> > -	int plen = strlen(prefix);
> > -	char *o_key;
> > +	char o_key[KEY_MAX_LEN];
> 
> I know this looks right but I think it will end up being a problem
> latter. I know there are places in the map lookup libraries that
> restrict these to KEY_MAX_LEN, which is needed for indirect map keys,
> but direct map keys really shouldn't have this restriction as they
> should be able to be as long as PATH_MAX but that brings the issue of
> needing to audit and adjust the maximum parse buffer as well. So we will
> need to get around to that at some point as well.

It certainly won't hurt to make this PATH_MAX - I'll do that unless I
hear otherwise.

> >  
> >  	/* root offset duplicates "/" */
> > -	if (plen > 1) {
> > -		o_key = alloca(plen + strlen(offset) + 1);
> > -		strcpy(o_key, prefix);
> > -		strcat(o_key, offset);
> > -	} else {
> > -		o_key = alloca(strlen(offset) + 1);
> > -		strcpy(o_key, offset);
> > -	}
> > +	if (snprintf(o_key, sizeof(o_key), "%s%s", prefix, offset) >
> > +	    sizeof(o_key))
> > +		return NULL;
> 
> Looks like this will set o_key to "//..." for strlen(prefix) == 1.

I'll fix it, thanks

-VAL
