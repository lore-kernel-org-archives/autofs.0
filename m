From: "atlantos41" <atlantos41@yandex.ru>
Subject: Re: Is autofs4 8-bit compatible?
Date: Thu, 10 Mar 2005 16:38:47 +0300 (MSK)
Message-ID: <42304DE7.00001F.23342@camay.yandex.ru>
Reply-To: atlantos41@yandex.ru
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: raven@themaw.net
Cc: autofs@linux.kernel.org

On Sunday 06 March 2005 05:10, raven@themaw.net wrote:
> Could you try this patch for me please.
>
> Ian
>
> --- autofs-4.1.4_beta2/modules/lookup_file.c.char-compare      2005-03-06
> 11:06:19.000000000 +0800 +++
> autofs-4.1.4_beta2/modules/lookup_file.c       2005-03-06 11:06:57.000000000
> +0800 @@ -147,7 +147,7 @@
>                                else if (ch == '*') {
>                                        state = st_star;
>                                        *(kptr++) = ch;
> -                              } else if (isprint((char) ch)) {
> +                              } else if (!iscntrl((char) ch)) {
>                                        state = st_compare;
>                                        *(kptr++) = ch;
>                                }


I've tried your patch and there are no difference - autofs continue to fail on mount as before.
