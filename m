From: raven@themaw.net
Subject: Re: Race in expire code
Date: Sat, 29 Jan 2005 22:13:25 +0800 (WST)
Message-ID: <Pine.LNX.4.61.0501292209240.14112@donald.themaw.net>
References: <Pine.LNX.4.61.0501292129280.14112@donald.themaw.net>
	<20050129135126.GA24017@uio.no>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20050129135126.GA24017@uio.no>
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
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Cc: autofs@linux.kernel.org

On Sat, 29 Jan 2005, Steinar H. Gunderson wrote:

> On Sat, Jan 29, 2005 at 09:36:31PM +0800, raven@themaw.net wrote:
>> Can everyone who is maintaining downstream packages please chaeck that
>> the code in their package ends up looking like what the patch below
>> acheives.
>>
>> [...]
>>
>>  	case EXP_STARTED:
>> -		sigprocmask(SIG_SETMASK, &ready_sigs, NULL);
>>  		ap.state = ST_EXPIRE;
>> +		sigprocmask(SIG_SETMASK, &ready_sigs, NULL);
>>  		return 0;
>>  	}
>>  	return 1;
>
> The Debian packages are close, but not quite:
>
>        case EXP_STARTED:
>                sigprocmask(SIG_SETMASK, &lock_sigs, NULL);
>                ap.state = ST_EXPIRE;
>                sigprocmask(SIG_SETMASK, &ready_sigs, NULL);
>                return 0;
>
> I have no idea what lock_sigs does, but this should be OK, no?

It's just the list of signals that are blocked while we do "stuff" that 
we don`t want interrupted by something else.

Similarly ready_sigs contains the signals we expect to be received 
in normal operation.

The first sigprocmask call above does nothing as signals are already 
blocked at that point.

Ian
