From: "Lever, Charles" <Charles.Lever@netapp.com>
Subject: Autofs4 4.1.3-28 with NetApp filer
Date: Sun, 20 Feb 2005 19:14:26 -0800
Message-ID: <482A3FA0050D21419C269D13989C611308539786@lavender-fe.eng.netapp.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
content-class: urn:content-classes:message
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
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

Customer of ours describes this problem:

  >    We have several netapp boxes that we use as filers and all 
  >    of them at this site, with the exception of this one box, would
unmount
  >    for the linux workstation after the autmount timeout period.
With the 
  >    implementation of autofs-4.1.3-28 this particular netapp box
would not
  >    only NOT unmount (/net mounts) after timeouts, and would not
release
  >    its ports, it would begin to actively take more ports (without
any
  >    other mounts of this netapp box taking place).  Within 24 hours a
linux
  >    box can be hung by the port-taking activity of this netapp box
mounted
  >    via /net.

They are running on RH 8.0, kernel 2.4.20-20.8smp.  Problem did not
occur with autofs-4.1.2.

Does this sound familiar to anyone?

        - Chuck Lever
--
corporate:     <cel at netapp dot com>
personal:      <chucklever at bigfoot dot com>
