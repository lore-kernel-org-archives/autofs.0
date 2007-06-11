From: Ian Kent <raven@themaw.net>
Subject: Re: Minor change to alarm_handler to avoid code	duplication
Date: Mon, 11 Jun 2007 12:52:25 +0800
Message-ID: <1181537545.3423.23.camel@shark.themaw.net>
References: <46680CEF.2080803@control.lth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <46680CEF.2080803@control.lth.se>
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
To: Anders Blomdell <anders.blomdell@control.lth.se>
Cc: autofs@linux.kernel.org

On Thu, 2007-06-07 at 15:49 +0200, Anders Blomdell wrote:
> As per request from discussions in
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=241780
> a patch against git.
> 
> Best regards
> 
> Anders Blomdell
> plain text document attachment (alarm_handler.patch)
> --- autofs/lib/alarm.c	2007-06-07 15:05:03.000000000 +0200
> +++ /usr/src/autofs/autofs.patched/lib/alarm.c	2007-06-07 15:08:29.000000000 +0200
> @@ -28,16 +28,16 @@
>  
>  #define alarm_lock() \
>  do { \
> -	int _alm_lock = pthread_mutex_lock(&mutex); \
> -	if (_alm_lock) \
> -		fatal(_alm_lock); \
> +	int status = pthread_mutex_lock(&mutex); \
> +	if (status) \
> +		fatal(status); \
>  } while (0)
>  
>  #define alarm_unlock() \
>  do { \
> -	int _alm_unlock = pthread_mutex_unlock(&mutex); \
> -	if (_alm_unlock) \
> -		fatal(_alm_unlock); \
> +	int status = pthread_mutex_unlock(&mutex); \
> +	if (status) \
> +		fatal(status); \
>  } while (0)

This isn't related to what your proposing.
A separate patch would have been better for this so that we could
discuss it independently of the alarm_handler patch.

This patch hunk reverts the code to what I originally wrote.
It was changed due to complaints about compile warning about reused
symbol names and "the right thing to do for readability". Personally I
prefer it this way but I'm not going to change this again.

Ian
