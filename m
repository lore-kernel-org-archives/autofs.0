From: Ian Kent <raven@themaw.net>
Subject: Re: What is the purpose of AUTOFS_NEGATIVE_TIMEOUT?
Date: Fri, 6 Aug 2004 10:56:52 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0408061055550.1816@wombat.indigo.net.au>
References: <BAY18-F10AKYVpMmOlb0000761f@hotmail.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <BAY18-F10AKYVpMmOlb0000761f@hotmail.com>
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
To: Takashi Yoshizawa <mz711@hotmail.com>
Cc: autofs@linux.kernel.org

On Wed, 28 Jul 2004, Takashi Yoshizawa wrote:

> Hi,
> 
> AUTOFS_NEGATIVE_TIMEOUT is defined in autofs_i.h.  I want to know this 
> purpose.
> In case of CD, "ls /mnt/cd/" without CD doesn't mount, and then insert CD,
> "ls /mnt/cd/" doesn't too.  Why?  I want it mount immediately.

You didn't specify your software setup including versions?

Ian
