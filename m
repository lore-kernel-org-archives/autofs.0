From: Pavel Troller <patrol@sinus.cz>
Subject: Re: automount 4.1.3: unmount timeout not working
Date: Sat, 29 Jan 2005 13:29:33 +0100
Message-ID: <20050129122933.GA10345@tangens.sinus.cz>
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
Reply-To: Pavel Troller <patrol@sinus.cz>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501291955090.10904@donald.themaw.net>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net
Cc: autofs@linux.kernel.org, silk@sinus.cz


> On Sat, 29 Jan 2005, Pavel Troller wrote:
> 
> >>
> >>OK. How about the log with a timeout of 10.
> >>
> >>Ian
> >
> >OK, here is it. Classic iso cd used instead of udf.
> >Sending just to You not to spam the list.
> 
> Can you try this patch please.
> 
> --- autofs-4.1.3-michael/daemon/automount.c.sig-fix	2005-01-19 
> 20:11:09.000000000 +0800
> +++ autofs-4.1.3-michael/daemon/automount.c	2005-01-19 
> 20:12:02.000000000 +0800
> @@ -920,8 +920,8 @@
>  		return 1;
> 
>  	case EXP_STARTED:
> -		sigprocmask(SIG_SETMASK, &ready_sigs, NULL);
>  		ap.state = ST_EXPIRE;
> +		sigprocmask(SIG_SETMASK, &ready_sigs, NULL);
>  		return 0;
>  	}
>  	return 1;
Hi Ian!
  It's unbelievable: IT WORKS!!!!
  In 3 sec intervals, the following now appears in the log:

Jan 29 13:19:28 arcus automount[13950]: sig 14 switching from 1 to 2
Jan 29 13:19:28 arcus automount[13950]: get_pkt: state 1, next 2
Jan 29 13:19:28 arcus automount[13950]: st_expire(): state = 1
Jan 29 13:19:28 arcus automount[13950]: expire_proc: exp_proc=14094
Jan 29 13:19:28 arcus automount[13950]: handle_child: got pid 14094, sig 0 (0), stat 0
Jan 29 13:19:28 arcus automount[13950]: sigchld: exp 14094 finished, switching from 2 to 1
Jan 29 13:19:28 arcus automount[13950]: get_pkt: state 2, next 1
Jan 29 13:19:28 arcus automount[13950]: st_ready(): state = 2

  And if there is a filesystem to umount, it's umounted in a flash!
  I even changed the timeout to my favourite 3 seconds and it works too!
  I can't explain it to myself: How such a simple change in the sequence of
the code can have such a big impact ?
  And why it works to most of people ? Really strange :-).
  But never mind, thank You very much! It's really great to have the automount
functional again!
                     With neverending thanks, Pavel
