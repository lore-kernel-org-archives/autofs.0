From: Quentin Arce <qarce@yahoo.com>
Subject: speed ? / problem
Date: Thu, 1 Jun 2006 08:49:48 -0700 (PDT)
Message-ID: <20060601154948.30806.qmail@web60817.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
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
To: autofs@linux.kernel.org

Hello,

I am mounting a Solaris 10 nfs export to my Linux box.
 When I perform an subversion svn co to the nfs
mounted area I see the data going in what seem to be
bursts.  i.e one or two pages of text fly by.  Then a
1 to 4 second pause.  Then another few pages.  A
checkout to local disk  on the linux box does not have
this problem.

mount options used:

rw,nosuid,nodev,noatime,hard,intr,rsize=8192,wsize=8192,tcp,actimeo=0

The nfs server is on the same subnet plugged into the
same switch.

Thank you for any insight you may have.

Q

 

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
