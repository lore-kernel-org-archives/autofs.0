From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: Race in expire code
Date: Sat, 29 Jan 2005 14:51:26 +0100
Message-ID: <20050129135126.GA24017@uio.no>
References: <Pine.LNX.4.61.0501292129280.14112@donald.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501292129280.14112@donald.themaw.net>
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
To: autofs@linux.kernel.org

On Sat, Jan 29, 2005 at 09:36:31PM +0800, raven@themaw.net wrote:
> Can everyone who is maintaining downstream packages please chaeck that 
> the code in their package ends up looking like what the patch below 
> acheives.
>
> [...]
> 
>  	case EXP_STARTED:
> -		sigprocmask(SIG_SETMASK, &ready_sigs, NULL);
>  		ap.state = ST_EXPIRE;
> +		sigprocmask(SIG_SETMASK, &ready_sigs, NULL);
>  		return 0;
>  	}
>  	return 1;

The Debian packages are close, but not quite:

        case EXP_STARTED:
                sigprocmask(SIG_SETMASK, &lock_sigs, NULL);
                ap.state = ST_EXPIRE;
                sigprocmask(SIG_SETMASK, &ready_sigs, NULL);
                return 0;

I have no idea what lock_sigs does, but this should be OK, no?

/* Steinar */
-- 
Homepage: http://www.sesse.net/
