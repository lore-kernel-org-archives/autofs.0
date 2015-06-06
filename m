From: Frank Thommen <frank.thommen@embl-heidelberg.de>
Subject: Re: Using wildcards in multi-mount maps
Date: Sat, 06 Jun 2015 20:02:17 +0200
Message-ID: <557335A9.2060408@embl-heidelberg.de>
References: <556B4D79.6030006@embl-heidelberg.de>	 <1433131113.2703.43.camel@pluto.fritz.box> <1433131806.2703.51.camel@pluto.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <1433131806.2703.51.camel@pluto.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org

On 06/01/2015 06:10 AM, Ian Kent wrote:
> On Mon, 2015-06-01 at 11:58 +0800, Ian Kent wrote:
>> On Sun, 2015-05-31 at 20:05 +0200, Frank Thommen wrote:
>>> Hi,
>>>
>>> are wildcards within multi-mount maps supposed to work?
>>
>> Good question.
>>
>>>
>>> I have the following entry in our maps:
>>>
>>> /etc/auto.master (local):
>>>      /mymount yp:mymap --ghost
>>>
>>>
>>> Indirect NIS map for /mymount:
>>>      $ ypmatch webapps mymap
>>>      /*         -timeo=30                   server:/local/exports/&
>>
>> Yeah, that can't work.
>>
>> [...]
>
> The other approach that might be useful is using submounts (Sun map
> format) like:
>
> webapps               -fstype=autofs autofs.wild
>
> where autofs.wild could contain:
> other-offset-submount             -fstype=autofs autofs.other-offsets
> *          -timeo=30               server:/local/exports/&
>
> and the map autofs.other-offsets is a subdirectory of lower level
> mounts. Obviously you would need one of these for each sub directory of
> mounts.

Solved it this way.  Thanks a lot
Frank
