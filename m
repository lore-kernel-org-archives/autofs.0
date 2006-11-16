From: Erich Weiler <weiler@soe.ucsc.edu>
Subject: Autofs hang, centos 4.4
Date: Thu, 16 Nov 2006 08:02:48 -0800
Message-ID: <455C8BA8.9070609@soe.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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

Hi All-

I'm having this problem with autofs under CentOS 4.4 linux that I was 
hoping someone could shed some light on...  Basically I have a bunch of 
auto.* tables set up in /etc.  They work fine.  What does not work fine 
is that when someone tries to automount a directory that doesn't exist, 
the command hangs forever, and has to be killed.  For instance:

% cd /projects/foo
[hangs]

because /projects/foo is unavailable.  Now let me make it a bit more 
complex:  The machine I'm mounting on is on a private network 
(10.x.x.x), the nfs server is on a public network.  There is no NAT 
routing to the public network.  I was assuming that because the machine 
could not reach the NFS server it would just fail or timeout, not hang 
the terminal...

I know this is an odd setup, but it is the way it is and I'm trying to 
deal with it.  :)  Am I out of luck?  Or can I tweak something to make 
this just fail or timeout?  Any advice would be greatly appreciated!!

Regards,
erich
