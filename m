From: raven@themaw.net
Subject: Re: automount 4.1.3: unmount timeout not working
Date: Sat, 29 Jan 2005 21:29:05 +0800 (WST)
Message-ID: <Pine.LNX.4.61.0501292123170.14112@donald.themaw.net>
References: <20050122215228.GA14303@tangens.sinus.cz>
	<Pine.LNX.4.61.0501262240140.1716@donald.themaw.net>
	<20050126194824.GA3627@tangens.sinus.cz>
	<Pine.LNX.4.61.0501291154590.1607@donald.themaw.net>
	<20050129044935.GA11104@tangens.sinus.cz>
	<Pine.LNX.4.61.0501291243130.1607@donald.themaw.net>
	<20050129060136.GA16475@tangens.sinus.cz>
	<Pine.LNX.4.61.0501291858060.10028@donald.themaw.net>
	<20050129112511.GA6016@tangens.sinus.cz>
	<Pine.LNX.4.61.0501291955090.10904@donald.themaw.net>
	<20050129122933.GA10345@tangens.sinus.cz>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20050129122933.GA10345@tangens.sinus.cz>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Pavel Troller <patrol@sinus.cz>
Cc: autofs@linux.kernel.org, silk@sinus.cz

On Sat, 29 Jan 2005, Pavel Troller wrote:

> Hi Ian!
>  It's unbelievable: IT WORKS!!!!

It took me a while to pick it first time.

Your the second win with this patch.
What I don't understand is why all of a sudden it starts happening.

>  In 3 sec intervals, the following now appears in the log:
>
> Jan 29 13:19:28 arcus automount[13950]: sig 14 switching from 1 to 2
> Jan 29 13:19:28 arcus automount[13950]: get_pkt: state 1, next 2
> Jan 29 13:19:28 arcus automount[13950]: st_expire(): state = 1
> Jan 29 13:19:28 arcus automount[13950]: expire_proc: exp_proc=14094
> Jan 29 13:19:28 arcus automount[13950]: handle_child: got pid 14094, sig 0 (0), stat 0
> Jan 29 13:19:28 arcus automount[13950]: sigchld: exp 14094 finished, switching from 2 to 1
> Jan 29 13:19:28 arcus automount[13950]: get_pkt: state 2, next 1
> Jan 29 13:19:28 arcus automount[13950]: st_ready(): state = 2
>
>  And if there is a filesystem to umount, it's umounted in a flash!
>  I even changed the timeout to my favourite 3 seconds and it works too!
>  I can't explain it to myself: How such a simple change in the sequence of
> the code can have such a big impact ?

It's a classic race. I think the state is ending up not being set 
correctly as signals are being unlocked to early. Consequently, automount 
doesn't pass through the right places to set the alarm for the expire.

Ian
