From: raven@themaw.net
Subject: RE: auto direct
Date: Wed, 21 Jul 2004 21:58:21 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0407212148130.1373@donald.themaw.net>
References: <200407211332.i6LDWPmh030349@ns4.ypf.com.ar>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200407211332.i6LDWPmh030349@ns4.ypf.com.ar>
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
To: EAGOMEZC@REPSOLYPF.COM
Cc: autofs@linux.kernel.org

On Wed, 21 Jul 2004 EAGOMEZC@REPSOLYPF.COM wrote:

> ok,
> 
> but why not ?

It is a limitation of the current implementation.

> 
> is it not posible ?

Not until the direct mount rework is done.
First I've spent a long time deciding on how best to implement it.
Second, the original method was used, largely due to the restricted number 
of anonymous mounts available in 2.4.
Third, the kernel module changes needed are a bit tricky. They'll need 
significant testing when the work is done, as will the userspace code.
Fourth, I've had a more or less constant stream of bug fix and basic 
functionality work needed with the package. It's way hard implement 
against a moving target.

> 
> is it not implemented yet ?

Above.

> 
> Can I help you ?

Perhaps. What do you have in mind?

Ian
