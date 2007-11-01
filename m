From: Xiwen Cheng <xcheng@math.leidenuniv.nl>
Subject: Attempt on mounting a non-existing directory
Date: Thu, 1 Nov 2007 11:16:33 +0100
Message-ID: <20071101101633.GJ30850@math.leidenuniv.nl>
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

Recently we migrated from static nfs mounts to autofs on our webserver.
This concerns all /home/*/public_html/ directories which are mounted
read-only by default. /etc/autofs/auto.home includes some exceptions
whereas certain users requested their ~/public_html or even ~/ to be
writable. 

This setup works _almost_ all the time although syslog reveals some
extremely strange behaviors, a snippet:

Oct 31 17:38:02 host1 automount[14335]: mount(nfs): nfs: mount failure
nfs.somewhere.com:/home/user/.bash_profile/public_html on
/home/user/.bash_profile/public_html

There are numerous similair failures including normal webserver
requests. The above sample was the result of a "su - user" if anyone
wonders.

The big question mark is: Why does autofs try to mount ~/public_html one
threshold/level lower? It shouldn't look any further than
/home/anyuser/public_html.  
~/public_html  

Server info
===========
OS:			2.6.19-gentoo-r5
net-fs/nfs-utils:	1.0.12-r1
net-libs/libnfsidmap:	0.19


An offtopic question: what is the real function of the -g (ghost) flag??
manpages aren't any help.


Thank you in advance,

xiwen
