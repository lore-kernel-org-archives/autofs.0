From: Frank Thommen <frank.thommen@embl-heidelberg.de>
Subject: Re: [PATCH] Add a --mode option to chmod the mount point of the maps
Date: Mon, 14 Sep 2015 11:20:34 +0200
Message-ID: <55F69162.5080601@embl-heidelberg.de>
References: <55F58085.4090509@excellency.fr>
 <1442197882.3030.33.camel@themaw.net> <55F68878.40803@excellency.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <55F68878.40803@excellency.fr>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: cbay@excellency.fr, Ian Kent <raven@themaw.net>
Cc: "autofs@vger.kernel.org" <autofs@vger.kernel.org>

On 14.09.15 10:42, Cyril B. wrote:
> Ian Kent wrote:
>> On Sun, 2015-09-13 at 15:56 +0200, Cyril B. wrote:
>>> It looks like the mount point of the maps have fixed permissions, 755. I
>>> need to have different permissions: in my use case, I want /home (which
>>> is handled by autofs) to be set to 751.
>>
>> Why is this needed?
>
> Why do I want to set /home to 751? When it was set to 755, I frequently
> had users believing there was a serious vulnerability because they could
> list /home. Stupid, I know, but setting the permissions to 751 was a
> trivial solution for this.
>
>>> The initial permissions of /home are overwritten when autofs is started,
>>> so changing those doesn't help.
>>
>> They aren't overwritten.
>> The permissions are those of the autofs mount that is mounted
>> over /home.
>
> I'm not sure I'm following you. Here's my auto.master:
>
> /home program:/etc/auto.home
>
> Before launching autofs, permissions are set to 751:
>
> # ls -ald /home
> drwxr-x--x 2 root root 4096 Aug  7 11:09 /home
>
> Once I've launched autofs, permissions are reset to 755:
>
> # ls -ald /home
> drwxr-xr-x 2 root root 0 Sep 14 10:32 /home

They are not "re"set.  These are the permissions of the filesystem that 
you are mounting over /home (e.g. myfileserver:/export/homes).  Change 
the permissions of /export/homes on myfileserver.

frank


>
> And when I quit autofs, my permissions are back to 751:
>
> # ls -ald /home
> drwxr-x--x 2 root root 4096 Aug  7 11:09 /home
>
> What I want is to always have /home permissions set to 751.
>
> Note that I'm not talking about mount points below /home (e.g.
> /home/foobar), those do have the correct permissions.
>


-- 
Frank Thommen - Structures IT Management and Support - EMBL Heidelberg
frank.thommen@embl-heidelberg.de - +49 6221 387 8353
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
