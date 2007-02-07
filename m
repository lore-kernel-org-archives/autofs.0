From: Ian Kent <raven@themaw.net>
Subject: Re: Ldap starting nis child?
Date: Wed, 07 Feb 2007 22:54:38 +0900
Message-ID: <1170856478.3415.8.camel@raven.themaw.net>
References: <20070206224910.GI21027@cornholio.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20070206224910.GI21027@cornholio.qualcomm.com>
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
To: Mike Marion <mmarion@qualcomm.com>
Cc: autofs@linux.kernel.org

On Tue, 2007-02-06 at 14:49 -0800, Mike Marion wrote:
> We're looking into some odd issue we're starting to have with our ldap
> autofs setup, and as I test I tried starting our direct map daemon
> without the --ghost flag, and it failed miserably.  the main moint
> points started properly (--debug was on) like so:
> automount[3217]: starting automounter version 4.1.4, path = /prj, maptype = ldap, mapname =
> automountmapname=auto.projects,ou=automountMaps,ou=sandiego,ou=qct,dc=qualcomm,dc=com
> 
> But as soon as you tried to traverse that, it spawned a maptype=yp
> child:
> automount[7893]: starting automounter version 4.1.4, path = /prj/vlsi, maptype = yp, mapname =
>  automountmapname=auto.projects,ou=automountMaps,ou=sandiego,ou=qct,dc=qualcomm,dc=com
> 
> Which eventually failed with a "RPC failure on NIS operation" and
> bombed.

To be honest, if you need to use direct maps, use version 5 and a recent
enough kernel. You can check the kernel patches in the tarball to work
out how much is in each kernel.

> 
> We're using 4.1.4 and have all the patches applied to the daemons.
> Using a sles10 2.6.16.21-0.8smp kernel (has latest kernel patches, or at
> least these: autofs4-2.6.10-20050404.patch).

If you really must use v4 then use a more recent kernel and/or use the
patches in the v5 tarball and send a debug log.

Ian
