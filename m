From: Ian Kent <raven@themaw.net>
Subject: Re: AFS + LDAP
Date: Thu, 06 Jul 2006 20:33:12 +0800
Message-ID: <1152189192.8761.24.camel@raven.themaw.net>
References: <20060706055029.GS19585@mail.iSKUNK.ORG>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20060706055029.GS19585@mail.iSKUNK.ORG>
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
To: "Daniel Richard G." <skunk@iskunk.org>
Cc: autofs@linux.kernel.org

On Thu, 2006-07-06 at 01:50 -0400, Daniel Richard G. wrote:
> Does there exist a standard(ish) LDAP schema for AFS mounts?
> 
> I'm familiar with the Hesiod record format, along the lines of e.g.
> 
> 	AFS /afs/athena.mit.edu/contrib/sipb n /mit/sipb 1
> 	AFS /afs/athena.mit.edu/user/y/o/yoav w /mit/yoav
> 
> (and supported by the Hesiod lookup module), but I'm interested in pulling 
> this same sort of information via LDAP.

I'm not familiar with the hesoid system but I assume that in the record
above we have:

AFS -> filesystem type
/afs/athena.mit.edu/user/y/o/yoav -> filesystem
w -> read/write option rw

The last field is confusing but it may be the key used by hes_resolve?
If so for autofs it would not normally be a path but a component such as
yoav here.

So you could store this in LDAP by one of the schema such as the NIS
schema by setting attributes for a distinguished name like:

dn: cn=yoav,nisMapName=mymap,dc=dncom1,dc=dncomp2:

as

cn: yoav
nisMapEntry: AFS /afs/athena.mit.edu/user/y/o/yoav w

and using something like:

/mymount	ldap,hesoid://server/nasMapName=mymap,dc=my,dc=dnname

as a master map entry.

There's a fair bit of detail left out because I'm not sure about it so
there would have to be some trial and error. But the ",hesoid" will send
the entry to the hesoid parser instead of the sun parser in the same way
as the hesoid lookup module does.

Ian
