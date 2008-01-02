From: muzzol <muzzol@muzzol.com>
Subject: Re: basic SOHO NFS/autofs setup for noob help
Date: Wed, 02 Jan 2008 21:45:02 +0100
Message-ID: <477BF7CE.7050709@muzzol.com>
References: <9b72f9a90801021042m65d350ak5467b4c500d94933@mail.gmail.com>	<x49lk7812d7.fsf@segfault.boston.devel.redhat.com>	<9b72f9a90801021110k3b3d74e7kb227b1e5bb772544@mail.gmail.com>	<x49hchw117z.fsf@segfault.boston.devel.redhat.com>
	<9b72f9a90801021137m38452b54s7a9af7a53967374e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <9b72f9a90801021137m38452b54s7a9af7a53967374e@mail.gmail.com>
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
To: Jerzy Jalocha N <jjalocha@gmail.com>
Cc: autofs@linux.kernel.org

En/na Jerzy Jalocha N ha escrit:
>> Of course it shows nothing.  What directories exist under /shared on
>> the server?  Try to cd to one of those.
> =

> Sorry, I am not very clear what I should expect from autofs, so I
> didn't post everything I've tested. But I've also tried to show the
> contents of a sub-directory without success:
>  $ ls /shared/subdir
> or
>  $ cd /shared/subdir
> (for some directory I know that exists.)
> But this just takes around 10 min to tell me that there's "No such
> file or directory".
> =


try

showmount -e <nfs server>


-- =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
      ^ ^
      O O
     (_ _)
muzzol(a)muzzol.com
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
jabber id: muzzol(a)jabber.dk
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
No atribueixis qualitats humanes als ordinadors.
No els hi agrada.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
"El gobierno espa=F1ol s=F3lo habla con terroristas, homosexuales y
catalanes, a ver cuando se decide a hablar con gente normal"
Jim=E9nez Losantos
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
<echelon spamming>
bomb terrorism bush aznar teletubbies
</echelon spamming>
