From: Mike Marion <mmarion@qualcomm.com>
Subject: Ldap starting nis child?
Date: Tue, 6 Feb 2007 14:49:10 -0800
Message-ID: <20070206224910.GI21027@cornholio.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
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
To: autofs@linux.kernel.org

We're looking into some odd issue we're starting to have with our ldap
autofs setup, and as I test I tried starting our direct map daemon
without the --ghost flag, and it failed miserably.  the main moint
points started properly (--debug was on) like so:
automount[3217]: starting automounter version 4.1.4, path = /prj, maptype = ldap, mapname =
automountmapname=auto.projects,ou=automountMaps,ou=sandiego,ou=qct,dc=qualcomm,dc=com

But as soon as you tried to traverse that, it spawned a maptype=yp
child:
automount[7893]: starting automounter version 4.1.4, path = /prj/vlsi, maptype = yp, mapname =
 automountmapname=auto.projects,ou=automountMaps,ou=sandiego,ou=qct,dc=qualcomm,dc=com

Which eventually failed with a "RPC failure on NIS operation" and
bombed.

We're using 4.1.4 and have all the patches applied to the daemons.
Using a sles10 2.6.16.21-0.8smp kernel (has latest kernel patches, or at
least these: autofs4-2.6.10-20050404.patch).

-- 
Mike Marion-Unix SysAdmin/Staff IT Engineer-http://www.qualcomm.com
[watching a baseball game]
Stewie: Why does that man drop his club before he runs? I would bring it with me.
==> Family Guy
