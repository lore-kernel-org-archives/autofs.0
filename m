From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Ldap starting nis child?
Date: Wed, 07 Feb 2007 11:11:35 -0500
Message-ID: <x49tzxyuevc.fsf@segfault.boston.devel.redhat.com>
References: <20070206224910.GI21027@cornholio.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20070206224910.GI21027@cornholio.qualcomm.com> (Mike Marion's
	message of "Tue, 6 Feb 2007 14:49:10 -0800")
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

==> On Tue, 6 Feb 2007 14:49:10 -0800, Mike Marion <mmarion@qualcomm.com> said:

Mike> We're looking into some odd issue we're starting to have with our ldap
Mike> autofs setup, and as I test I tried starting our direct map daemon
Mike> without the --ghost flag, and it failed miserably.  the main moint
Mike> points started properly (--debug was on) like so:
Mike> automount[3217]: starting automounter version 4.1.4, path = /prj, maptype = ldap, mapname =
Mike> automountmapname=auto.projects,ou=automountMaps,ou=sandiego,ou=qct,dc=qualcomm,dc=com

Mike> But as soon as you tried to traverse that, it spawned a maptype=yp
Mike> child:
Mike> automount[7893]: starting automounter version 4.1.4, path = /prj/vlsi, maptype = yp, mapname =
Mike>  automountmapname=auto.projects,ou=automountMaps,ou=sandiego,ou=qct,dc=qualcomm,dc=com

Mike> Which eventually failed with a "RPC failure on NIS operation" and
Mike> bombed.

Mike> We're using 4.1.4 and have all the patches applied to the daemons.
Mike> Using a sles10 2.6.16.21-0.8smp kernel (has latest kernel patches, or at
Mike> least these: autofs4-2.6.10-20050404.patch).

So, you're using submounts?  Posting maps would be helpful, here!  My
guess is that the autofs code is not looking up the maptype for the
submounts in the name service switch.  If I'm right, I think I've
fixed this in the RHEL package, and I should have sent that patch
along to Ian in my last patch set.

As Ian says, we'd like to focus development on v5.  However, you'll
have to tell us what your constraints are and we'll see what we can do
to work within those.

Thanks!

Jeff
