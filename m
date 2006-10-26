From: "marty" <leisner@rochester.rr.com>
Subject: --timeout doesn't do anything on fedora3 or 5
Date: Wed, 25 Oct 2006 21:26:47 -0400
Message-ID: <000301c6f89d$ce6afdb0$9600a8c0@home>
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
Cc: leisner@rochester.rr.com

On both fedora3 and fedora5, I can't get the --timeout option on autofs to 
do anything useful.

I saw a bug report on fedora3, but getting a newer release doesn't seem to 
make a difference.
http://linux.derkeiler.com/Mailing-Lists/Fedora/2005-02/0488.html

Is there anyway to "monitor" the timeout interactively from user space 
(instead of "waiting" to see if it happens,
watch to see its counting down?)

marty 
