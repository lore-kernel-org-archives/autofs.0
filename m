From: Leonardo Chiquitto <leonardo.lists@gmail.com>
Subject: Re: AutoFS creates unmountable directories when ghosting
	is enabled
Date: Sun, 6 Mar 2011 23:37:56 -0300
Message-ID: <AANLkTikY+xO2voYOQqFR6qUyKusLBbknNLGLda6nHVbY@mail.gmail.com>
References: <20101210191042.GA4396@libre.l.ngdn.org>
	<1292381344.2979.6.camel@perseus>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:mime-version:in-reply-to:references:date
	:message-id:subject:from:to:cc:content-type
	:content-transfer-encoding;
	bh=016pKR3Qzji+LwHuKbXHnK3dR4o5VjXOBe8KeJZ8uig=;
	b=gsX01PVvaqxtM4g60UOvMMErpjERaxj9tc/+r8iDPkFSqGFPitiLwoYRIYM61b7zxh
	iEisvWNQnd0E5GjxdY4RNeIhrop7/3nblM2EUUT33IFPcptwZ9R2Da9drXaRTKh01tUf
	SzuJ3cdZbh3f9Qw02SLEVOCh8W/Ley4MAoWRQ=
In-Reply-To: <1292381344.2979.6.camel@perseus>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On Wed, Dec 15, 2010 at 12:49 AM, Ian Kent <raven@themaw.net> wrote:
> On Fri, 2010-12-10 at 17:10 -0200, Leonardo Chiquitto wrote:
>> Hello Ian and list,
>>
>> I'd like to forward a bug report we received on openSUSE's Bugzilla [1].
>> Please consider the following setup to reproduce the problem:
>>
>> host:~ # grep automount /etc/nsswitch.conf
>> automount: =A0 =A0files
>>
>> host:~ # cat /etc/auto.master
>> /vol =A0/etc/auto.vol
>>
>> host:~ # cat /etc/auto.vol
>> data1 -fstype=3Dnfs,ro,rsize=3D8192,wsize=3D8192,intr,nolock,nosuid srv:=
/data1
>> data2 -fstype=3Dnfs,ro,rsize=3D8192,wsize=3D8192,intr,nolock,nosuid srv:=
/data2
>> data3 -fstype=3Dnfs,ro,rsize=3D8192,wsize=3D8192,intr,nolock,nosuid srv:=
/data3
>>
>> host:~ # cat /etc/sysconfig/autofs
>> AUTOFS_OPTIONS=3D""
>> LOCAL_OPTIONS=3D""
>> APPEND_OPTIONS=3D"yes"
>> DEFAULT_MASTER_MAP_NAME=3D"auto.master"
>> DEFAULT_TIMEOUT=3D600
>> DEFAULT_BROWSE_MODE=3D"yes"
>> DEFAULT_LOGGING=3D"debug"
>> USE_MISC_DEVICE=3D"yes"
>>
>> host:~ # ls -F /vol
>> data1/ =A0data2/ =A0data3/
>>
>> The problem depends on ghosting being enabled (ie, BROWSE_MODE=3Dyes).
>> When we try to access a non-existent key/entry, AutoFS will fail to mount
>> it but will still create the mount point:
>>
>> host:~ # ls -d /vol/invalid; sleep 10; ls -d /vol/invalid
>> ls: cannot access /vol/invalid: No such file or directory
>> /vol/invalid
>>
>> host:~ # ls -F /vol
>> data1/ =A0data2/ =A0data3/ =A0invalid/
>>
>> The problem happens because lookup_ghost() iterates over all cached
>> mapents and creates directories for each entry in the cache. Since
>> the cache also stores entries for failed mounts (negative entries), it
>> ends up creating directories for mount points that don't exist in the
>> map.
>
> Yes, an obvious problem.
>
>>
>> I tested the patch below and it resolves the problem for me, but I'm not
>> sure if this is the best (or even the correct) way to fix the bug. I'd
>> appreciate if you could review and comment.
>
> Yeah, at first I thought there were a few other cases.
> There still might be so let me think about it further.

Hello Ian,

I bisected this problem today and discovered that it appeared after the
following commit:

commit 08aafab4c1d0ab6227c80f8cd1086ae78556a370
Author: Ian Kent <raven@themaw.net>
Date:   Thu Sep 9 11:10:47 2010 +0800

    autofs-5.0.5 - fix direct map not updating on reread

    If the map type is explicitly specified for a map the map isn't
    properly updated when a re-read is requested. This is because
    the map stale flag is incorrectly cleared after after the lookup
    module reads the map instead of at the completion of the update
    procedure. The map stale flag should only be cleared if the map
    read fails for some reason, otherwise it is updated when the
    refresh is completed.

Does this ring a bell? If not, I'll see if I can debug it further tomorrow.

Thanks,
Leonardo
