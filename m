From: raven@themaw.net
Subject: Re: error in 2.6
Date: Thu, 29 Apr 2004 21:28:57 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0404292122190.22153@donald.themaw.net>
References: <Sea2-F25dMtyYZMqDu30002a966@hotmail.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Sea2-F25dMtyYZMqDu30002a966@hotmail.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "idiot)_) supreme" <ejw50@hotmail.com>
Cc: autofs@linux.kernel.org

On Wed, 28 Apr 2004, idiot)_) supreme wrote:

> I am running autofs4.1, kernel 2.6.5, with the ~7 or so patches.  I got this error today
> (/net/d4m/ears is an automount directory).  It logged me out, then when I tried on a different
> directory I got the second error  and got kicked out again.  I did not do any further
> debugging, but I thought you might want to know.  If there's anything you want me to try, let
> me know.
>

What revision are you using.
You need the 20040417 set.

Please inspect the file fs/autofs4/root.c and look for:

	int flags = nd ? nd->flags : 0;

in the declarations near the top of the function autofs4_revalidate.

If you haven't got this you have a broken version of the patches.

Ian
