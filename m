From: raven@themaw.net
Subject: Re: Is autofs4 8-bit compatible?
Date: Sun, 27 Mar 2005 11:01:51 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0503271100480.2479@donald.themaw.net>
References: <42304DE7.00001F.23342@camay.yandex.ru>
Mime-Version: 1.0
In-Reply-To: <42304DE7.00001F.23342@camay.yandex.ru>
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
To: atlantos41 <atlantos41@yandex.ru>
Cc: autofs@linux.kernel.org

On Thu, 10 Mar 2005, atlantos41 wrote:

> On Sunday 06 March 2005 05:10, raven@themaw.net wrote:
>> Could you try this patch for me please.
>>

snip ...

>
> I've tried your patch and there are no difference - autofs continue to fail on mount as before.
>

Could you try this one please?

--- autofs-4.1.3/modules/lookup_file.c.wide_char	2005-03-27 10:47:16.000000000 +0800
+++ autofs-4.1.3/modules/lookup_file.c	2005-03-27 10:48:32.000000000 +0800
@@ -148,7 +148,7 @@ static int read_one(FILE *f, char *key,
  				else if (ch == '*') {
  					state = st_star;
  					*(kptr++) = ch;
-				} else if (isprint((char) ch)) {
+				} else {
  					state = st_compare;
  					*(kptr++) = ch;
  				}
@@ -164,7 +164,7 @@ static int read_one(FILE *f, char *key,
  				getting = got_real;
  				state = st_entspc;
  			} else if (escape == esc_char);
-			else if (isprint((char) ch))
+			else
  				*(kptr++) = ch;
  			break;
