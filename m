From: Ian Kent <raven@themaw.net>
Subject: Re: Can I "null" out NIS maps with autofs?
Date: Tue, 31 Aug 2004 21:17:01 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0408312113150.2756@raven.themaw.net>
References: <413400C3.2010203@cjs226.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <413400C3.2010203@cjs226.com>
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
To: Clif Smith <kernel@cjs226.com>
Cc: autofs@linux.kernel.org

On Mon, 30 Aug 2004, Clif Smith wrote:

> Occasionally I need to use all but 1 or 2 NIS maps with automount.  With 
> AIX and Solaris, I've been able to use the -null arg.  However that 
> doesn't seem to work with autofs?

Sorry again.

It's actually worse than simply not having the null option.

First, this is a master map option but the master map is processed by the 
init script so at best the automount(8) daemon will not be run at all.

Second, if an empty map is given to automount(8) it exits.

It's one of the things we need to do but I can't say when that might be.

Ian
