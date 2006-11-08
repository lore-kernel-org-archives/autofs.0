From: Ian Kent <raven@themaw.net>
Subject: Re: problem with autofs
Date: Wed, 08 Nov 2006 12:12:13 +0800
Message-ID: <1162959133.3555.11.camel@localhost>
References: <29c5cd460611060850p4972e906s65990c968db963e4@mail.gmail.com>
	<x49psbzxtfa.fsf@segfault.boston.devel.redhat.com>
	<29c5cd460611070612x1d046f91u3a3c0577bb1fd77@mail.gmail.com>
	<x49ejsfxqix.fsf@segfault.boston.devel.redhat.com>
	<1162912613.18975.59.camel@localhost>
	<29c5cd460611070732h1cbdd998n3dd627c4e554b98a@mail.gmail.com>
	<x497iy7xmtp.fsf@segfault.boston.devel.redhat.com>
	<29c5cd460611070820o6cb2a08fp2c9e9adf67651ce3@mail.gmail.com>
	<x493b8vxeqr.fsf@segfault.boston.devel.redhat.com>
	<29c5cd460611071953w5c3ab139w274c75b913aee36e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <29c5cd460611071953w5c3ab139w274c75b913aee36e@mail.gmail.com>
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
To: Syed Khader <syedk@google.com>
Cc: autofs@linux.kernel.org

On Wed, 2006-11-08 at 09:23 +0530, Syed Khader wrote:
> Jeff,
> It gives me
>  
> dn: cn=/home,dc=testlab,dc=com
> and the automount information which i specified in the auto.home map.
>  
> I think Ldap entries are fine,but the problem is to make autofs read
> from the LDAP rather than files.

No. The problem right now is to understand why the
autofs-ldap-auto-master program is not able to read the LDAP master map.

>  
> Thanks,
> Abdul.
> 
> 
>  
> On 11/8/06, Jeff Moyer <jmoyer@redhat.com> wrote: 
>         ==> Regarding Re: [autofs] problem with autofs; "Syed Khader"
>         <syedk@google.com> adds:
>         
>         syedk> Hi Jeff,
>         syedk> Here's the output
>         
>         >> ldapsearch -x -s subtree
>         '(&(objectclass=automountMap)(ou=auto.master))'
>         
>         syedk> dn:ou=auto.master,dc=testlab,dc=com 
>         syedk> objectClass:top
>         syedk> objectClass:automountMap
>         syedk> ou:auto.master
>         
>         syedk> I have configured to allow anonymous bind.No ACLS are
>         given
>         
>         OK, then what do you get with this:
>         
>         ldapsearch -x -s subtree -b 'ou=auto.master,dc=testlab,dc=com'
>         'objectclass=automount'
>         
>         -Jeff
> 
