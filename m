From: Phy Prabab <phyprabab@yahoo.com>
Subject: Possbile issue with ghost and timeout
Date: Sat, 26 Jun 2004 12:09:12 -0700 (PDT)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20040626190912.27576.qmail@web51801.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

Hello,

I am not on this mailing list yet, so please cc me in
the mails.

I have an issue with autofs4.1.3 and ghost option.  It
appears that onve a file system has been mounted and
then time-out removed, the file system will not be
remounted unless you cd or ls the dir.  For example: 
I run an executable by using the full path via an rsh
command and then run the command again after the
timeout (30s in my case) and the file is not found. 
However if I "ls" the path the executable is there and
then accessable.

If I remove the ghost option, everything behaves fine.

Is this a known issue and is there a fix/work around?

Thanks!
Phy


		
__________________________________
Do you Yahoo!?
Yahoo! Mail - 50x more storage than other providers!
http://promotions.yahoo.com/new_mail
