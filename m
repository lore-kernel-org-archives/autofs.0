From: "atlantos41" <atlantos41@yandex.ru>
Subject: Re: Is autofs4 8-bit compatible?
Date: Sun, 3 Apr 2005 07:51:25 +0400 (MSD)
Message-ID: <424F683D.000001.08082@tide.yandex.ru>
Reply-To: atlantos41@yandex.ru
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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

On Sunday 27 March 2005 06:01, raven@themaw.net wrote:
> Could you try this one please?
>
> --- autofs-4.1.3/modules/lookup_file.c.wide_char       2005-03-27
> 10:47:16.000000000 +0800 +++ autofs-4.1.3/modules/lookup_file.c        2005-03-27
> 10:48:32.000000000 +0800 @@ -148,7 +148,7 @@ static int read_one(FILE *f,
> char *key,
>                                else if (ch == '*') {
>                                        state = st_star;
>                                        *(kptr++) = ch;
> -                              } else if (isprint((char) ch)) {
> +                              } else {
>                                        state = st_compare;
>                                        *(kptr++) = ch;
>                                }
> @@ -164,7 +164,7 @@ static int read_one(FILE *f, char *key,
>                                getting = got_real;
>                                state = st_entspc;
>                        } else if (escape == esc_char);
> -                      else if (isprint((char) ch))
> +                      else
>                                *(kptr++) = ch;
>                        break;



I tried this patch and now automount mounts all shares. But automount can't umount mounted shares with 8-bit chars in share names - I have entries in syslog like (I start autofs with command `automount --timeout=60 --verbose /smb file /etc/auto.smb``):

Apr  2 16:29:15 localhost automount[29323]: umount_multi: no mounts found under /smb/test_data
Apr  2 16:29:15 localhost automount[29323]: expired /smb/test_data
Apr  2 16:30:15 localhost automount[29384]: umount_multi: no mounts found under /smb/test_data
Apr  2 16:30:15 localhost automount[29384]: expired /smb/test_data
Apr  2 16:31:15 localhost automount[29384]: umount_multi: no mounts found under /smb/test_data
Apr  2 16:31:15 localhost automount[29384]: expired /smb/test_data
