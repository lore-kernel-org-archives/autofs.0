From: Ian Kent <raven@themaw.net>
Subject: Re: parse_sun.c error
Date: Fri, 28 Jul 2006 12:46:45 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0607281245120.3022@raven.themaw.net>
References: <C4094AFA0A6.00000427bradla@inbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <C4094AFA0A6.00000427bradla@inbox.com>
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
To: Brad Arrington <bradla@inbox.com>
Cc: autofs@linux.kernel.org

On Sun, 23 Jul 2006, Brad Arrington wrote:

Thanks Brad,

> 
> 5.0.1-rc1

Apply the patches on kernel.org and check again.
I think you'll find this is completely different now.

> 
>     647         what = alloca(loclen + 1);
>     648         memcpy(what, loc, loclen);
>     649         what[loclen] = '\0';
>     650 /*
>     651         if (!strcmp(fstype, "autofs") && strchr(loc, ':') == NULL) {
>     652                 char mtype[7];
>     653                 int mtype_len;
>     654
>     655                 if (loc[0] == '/') {
>     656                         mtype_len = 5;
>     657                         if (loc[1] == '/')
>     658                                 strcpy(mtype, "ldap:");
>     659                         else
>     660                                 strcpy(mtype, "file:");
>     661                 } else {
>     662                         mtype_len = 3;
>     663                         strcpy(mtype, "yp:");
>     664                 }
>     665
>     666                 what = alloca(loclen + mtype_len + 1);
>     667                 memcpy(what, mtype, mtype_len);
>     668                 memcpy(what + mtype_len, loc, loclen);
>     669                 what[loclen + mtype_len] = '\0';
>     670         } else {
>     671 */
>     672                 what = alloca(loclen + 1);
>     673                 memcpy(what, loc, loclen);
>     674                 what[loclen] = '\0';
>     675 /*      } */
> 

Ian
