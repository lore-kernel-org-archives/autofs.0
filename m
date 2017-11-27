From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 3/3] autofs - fix AT_NO_AUTOMOUNT not being honored
Date: Tue, 28 Nov 2017 07:43:05 +0800
Message-ID: <fe35e57a-df04-3e77-a717-48483c01701a@themaw.net>
References: <149438991819.26550.11290804420751932707.stgit@pluto.themaw.net>
 <149438992850.26550.14370272866390445786.stgit@pluto.themaw.net>
 <874lpo2y9e.fsf@notabene.neil.brown.name>
 <ed908288-536c-d34a-6d3d-c21bb8fdfc62@themaw.net>
 <864efc64-c430-a862-3e98-fe5ce2535329@themaw.net>
 <20171127160147.GA27613@qualcomm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=dmu5l/4XvFNuJfSI68G2YhtLcnC98
        9njvX3CVGWJ1m8=; b=JbtG6yHy+4b9wvTrwdExaW1Ujruz3j2yWik1FCZydnBkd
        pmfJuSuXjPPnIGAwLyf4xIQcgyiZA+5lQrGTlPP4OhPh8rb2uL5OPEzehwa15OmR
        hWFhXEiwt3XNIvcEX65X/JtJo0qEBnqK7haPajkXHg7UoAcoZp2fHI+KWNw7bLRl
        lGr4fPjjeL9u68UesGzjB4nicVaQbt+7JCX2btXwZIycqNNPsvvw9pgFa+ziIpei
        2WXASp5/Ak0vS+i1zMGKrfWqwUZn9zrsABse5wYt70VD5eYN69xEJTMeuRclByex
        buAO24Je8eX14umwZRguX2RtYlhlpc7o4kG/nCLfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=dmu5l/
        4XvFNuJfSI68G2YhtLcnC989njvX3CVGWJ1m8=; b=As7grDTmCvZCEahkBBJem4
        TeRZJjlkBLeKzU1pVJhKgZ/dN3Xyfp931GeQrUte5oCzutTnz76Iq3o8MEsztEhz
        IdbTq4XqwifXTvN0OrgJHCT5/mq7M6R4/xMZWDSHA1RQI7eXUjLdPl03Eyw4sOed
        VVaj1cOOiCPIhO2jb6cYSuQ+LS8xuPkrZeR/O/lpOd+3qOLmRzFPSbGwZcFD9+M/
        /PL0w2zpotFATqvDUjs2itf8TsX7rqxkPl7lPhwyu55VskTUc+pe4zXgyKq1Q/ga
        YwgRYYS153vesPkHxH5uMyQXnbS1vSxFFjffIXSczQYzqs08uuVxXlWOhPEsYHsQ
        ==
In-Reply-To: <20171127160147.GA27613@qualcomm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Mike Marion <mmarion@qualcomm.com>
Cc: NeilBrown <neilb@suse.com>, Al Viro <viro@ZenIV.linux.org.uk>, Colin Walters <walters@redhat.com>, Ondrej Holy <oholy@redhat.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

On 28/11/17 00:01, Mike Marion wrote:
> On Thu, Nov 23, 2017 at 08:36:49AM +0800, Ian Kent wrote:
> 
>> And with the move of userspace to use /proc based mount tables (one
>> example being the symlink of /etc/mtab into /proc) even modest sized
>> direct mount maps will be a problem with every entry getting mounted.
>>
>> Systems will cope with this fine but larger systems not so much.
> 
> Yes.. we've run into some big issues due to the change of /etc/mtab from
> a file to a symlink to /proc/self/mounts.  Most have been worked around
> thus far (mostly due to Suse coming up with patches) but still have a
> few annoying ones.
> 

I think the situation is going to get worse before it gets better.

On recent Fedora and kernel, with a large map and heavy mount activity
I see:

systemd, udisksd, gvfs-udisks2-volume-monitor, gvfsd-trash,
gnome-settings-daemon, packagekitd and gnome-shell

all go crazy consuming large amounts of CPU.

Once the mount activity is completed I see two processes continue to
consume a large amount of CPU. I thought one of those two was systemd
but my notes say they were gvfs-udisks2-volume-monitor and
gnome-settings-daemon.

The symlink change was probably the start, now a number of applications
now got directly to the proc file system for this information.

For large mount tables and many processes accessing the mount table
(probably reading the whole thing, either periodically or on change
notification) the current system does not scale well at all.

Ian
