From: "Daniel Richard G." <skunk@iskunk.org>
Subject: Re: AFS + LDAP
Date: Thu, 6 Jul 2006 15:40:24 -0400
Message-ID: <20060706194023.GG32706@mail.iSKUNK.ORG>
References: <20060706055029.GS19585@mail.iSKUNK.ORG>
	<1152189192.8761.24.camel@raven.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <1152189192.8761.24.camel@raven.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

On Thu, 2006 Jul 06 20:33:12 +0800, Ian Kent wrote:
> 
> I'm not familiar with the hesoid system but I assume that in the record
> above we have:
> 
> AFS -> filesystem type
> /afs/athena.mit.edu/user/y/o/yoav -> filesystem
> w -> read/write option rw

Aye, that's right.

> The last field is confusing but it may be the key used by hes_resolve?
> If so for autofs it would not normally be a path but a component such as
> yoav here.

It's the mount point, actually. The original way of working is that you 
would mount the volume by invoking "attach sipb" or "attach yoav", without 
reference to a base path. /mit is the usual location, but some special 
volumes (e.g. for system software) mount elsewhere in the filesystem.

> So you could store this in LDAP by one of the schema such as the NIS
> schema by setting attributes for a distinguished name like:
> 
[...]
> 
> cn: yoav
> nisMapEntry: AFS /afs/athena.mit.edu/user/y/o/yoav w
> 
[...]
> 
> There's a fair bit of detail left out because I'm not sure about it so
> there would have to be some trial and error. But the ",hesoid" will send
> the entry to the hesoid parser instead of the sun parser in the same way
> as the hesoid lookup module does.

Hmm. So it would basically be a Hesiod record stuffed into an LDAP 
attribute... and (if I understand correctly) autofs is currently limited to 
this sort of approach as _something_ ultimately has to be fed to the Hesiod 
parser.

I was hoping for something more along the lines of an extension to the 
standard NIS schema. (It's common for AFS sites to have each user's home 
directory be a separately mountable volume, so having some sort of 
user-volume equivalence in LDAP is reasonable.)

I take it something like this would require new code to support, then? And 
how would this work---pulling data from LDAP, but not doing any parsing per 
se (as the information is already broken out into attributes); there would 
be no lookup/parser disjunction. Should there be any issue with a backend 
module that effectively does both tasks?


--Daniel


-- 
NAME   = Daniel Richard G.       ##  Remember, skunks       _\|/_  meef?
EMAIL1 = skunk@iskunk.org        ##  don't smell bad---    (/o|o\) /
EMAIL2 = skunk@alum.mit.edu      ##  it's the people who   < (^),>
WWW    = http://www.******.org/  ##  annoy them that do!    /   \
--
(****** = site not yet online)
