From: Ian Kent <raven@themaw.net>
Subject: Re: /net with program map problem on x86_64
Date: Mon, 2 Feb 2004 01:21:02 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0402020117160.266-100000@donald.themaw.net>
References: <200403060204.i2624NgQ000399@miguelito.qualcomm.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200403060204.i2624NgQ000399@miguelito.qualcomm.com>
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
To: mmarion@qualcomm.com
Cc: autofs@linux.kernel.org

On Fri, 5 Mar 2004 mmarion@qualcomm.com wrote:

> Here's a new one I've run into.  Finally got a full auto-yast install setup
> for Suse SLES8 on a dual opteron system that incorporates all our company
> configurations automatically as well.
>
> I'm running the beta 4.1.1 code (don't know if it's released to wide audience
> yet) and it's been running perfectly fine on x86 hosts for a month or more.

Your going to haye me for this but a debug trace of the kernel module
would be good.

You can do this by setting the DEBUG define in the kernel module source
file autofs_i.h.

Beware there is going to be quite a bit of output.

Ian
