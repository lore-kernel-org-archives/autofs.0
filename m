From: Joe Perches <joe@perches.com>
Subject: Re: PATCH - 2.6.6-bk3 autofs4 DPRINTK cleanup
Date: Sun, 16 May 2004 21:51:10 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <1084769470.21217.11.camel@localhost.localdomain>
References: <1084753980.21164.6.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0405170954280.10453@wombat.indigo.net.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405170954280.10453@wombat.indigo.net.au>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org, jeremy@goop.org

On Sun, 2004-05-16 at 19:04, Ian Kent wrote:
> Hi Joe,
> 
> Why are you removing the function names from the printks?

Hi Kent.

The function names were moved to the DPRINTK macro itself
so they can't be out of date again.

Regards,  Joe

 #ifdef DEBUG
-#define DPRINTK(D) do{ printk("pid %d: ", current->pid); printk D; } while(0)
+#define DPRINTK(fmt,args...) do { printk(KERN_DEBUG "pid %d: %s: " fmt "\n" , current->pid , __FUNCTION__ , ##args); } while(0)
 #else
-#define DPRINTK(D) do {} while(0)
+#define DPRINTK(fmt,args...) do {} while(0)
 #endif
