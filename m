From: "Taylor, ForrestX" <forrestx.taylor@intel.com>
Subject: Re: auto.net
Date: Thu, 22 Jan 2004 09:35:31 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <401009E3.2090709@intel.com>
References: <B94D9EFEABBFD745A8BCFC0F658E3D740390C427@sussfe01.sikorsky.com>
Mime-Version: 1.0
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
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "Myers, Parrish" <PMyers@sikorsky.com>
Cc: autofs@linux.kernel.org

Myers, Parrish wrote:
> Hello,
> 
> I was wondering if I could get some help?  I am kinda new to the autofs
> thing... I think this is a simple question: Is there a simple way to tell if
> I have autofs4 built into my linux kernel?  And, if it isn't, does this
> still affect the use of auto.net (which is a replacement for the '-host'
> flag in the sgi verison)? I am having problems with getting auto.net to
> work. Everything in the setup seems to say it sould work: it does everyting
> but actually mound the directories.


You must use autofs4 for auto.net to work.  Try `/sbin/lsmod | grep autofs`.

If you see autofs, then you are using the old autofs3 module.  Stop 
autofs and remove the module (/etc/init.d/autofs stop ; modprobe -r 
autofs).  Edit /etc/modules.conf and add this line:
alias autofs autofs4
Restart autofs and see if it works.

If you see autofs4, then you are using the autofs4 module, and something 
else is wrong.  Check /var/log/message on the client machine and the 
machine that you are trying to connect to.

If you don't see autofs, then you may have autofs built into the kernel. 
  You'll have to look at the kernel configuration to see whether or not 
you included it.

Forrest
