From: Thanh Tran <ttran7700@yahoo.com>
Subject: Fedora 8 And Autofs
Date: Tue, 12 Aug 2008 16:03:22 -0700 (PDT)
Message-ID: <13624.9146.qm@web54302.mail.re2.yahoo.com>
Reply-To: ttran7700@yahoo.com
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

I'm sorry if this is a repost.  I'm not sure if the 1st one got through.  I've been using autofs just fine on Fedora 5.  I recently upgraded to Fedora 8.  I ran yum install autofs to get the latest.  Then, I updated my auto.master file to match my old one under Fedora 5.  It does not seem to work.  The autofs does not seem to load my master mount file.  I checked hal and it's happy as a clam.  It sees new devices being added when I plug my usb cdrom and usb memory stick.  I looked at the autofs script in /etc/init.d and compared it to the one on Fedora 5 and they totally different.  Could someone please direct me to a tutorial?  I never had this much trouble on Fedora 5.
