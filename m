From: Peter Schmidt <schmidt@pasemi.com>
Subject: Map file search list question
Date: Thu, 13 Nov 2008 14:23:23 -0800 (PST)
Message-ID: <46171233.15261226615003069.JavaMail.root@postoffice>
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

(Sorry if this turns up as a double post as I first tried to post from a non list account)

I think what I want is provided by the replicated server feature but I can't get it to work.

I want to search multiple map files that refer to the same mount point.
e.g  in the auto.master file can I do something like:

/home   yp:auto.home1,ldap:nisMapName=auto.home2,ou=mygroup,o=mycompany

If it can't find the entry in auto.home1 then query auto.home2
