From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [patch rfc] don't exit from parent until autofs can
	service requests
Date: Fri, 3 Jun 2005 15:25:25 -0400
Message-ID: <17056.44709.386981.760240@segfault.boston.redhat.com>
References: <17053.50761.832966.775060@segfault.boston.redhat.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <17053.50761.832966.775060@segfault.boston.redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

==> Regarding [autofs] [patch rfc] don't exit from parent until autofs can service requests; Jeff Moyer <jmoyer@redhat.com> adds:

[snip]

Stupid thinko:

> +static void daemon_status(int code, const char *fmt, ...)
> +{
> +	va_list ap;
> +	struct daemon_status_msg msg;
> +	char buf[DAEMON_STATUS_MSG_SZ];
> +	int ret = 0;
> +
> +	if (submount || daemon_status_fd < 0)
> +		return;
> +
> +	msg.code = code;
> +	if (code) {
> +		va_start(ap, fmt);
> +		ret = vsnprintf(buf, DAEMON_STATUS_MSG_SZ, "%s", ap);
                                                           ^^^

That should be fmt, of course.

> +	if (code) {
> +		va_start(ap, fmt);
> +		ret = vsnprintf(buf, DAEMON_STATUS_MSG_SZ, fmt, ap);
> +		va_end(ap);
> +		if (ret > DAEMON_STATUS_MSG_SZ)
> +			ret = DAEMON_STATUS_MSG_SZ - 1;
> +	}

And here it should be if ret >= DAEMON_STATUS_MSG_SZ, since the consumer
sets buf[msg.len] to NULL.

-Jeff
