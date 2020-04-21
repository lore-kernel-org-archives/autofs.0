From: Emanuele Giuseppe Esposito <eesposit@redhat.com>
Subject: Re: [PATCH 2/8] fs: extract simple_pin/release_fs to separate files
Date: Tue, 21 Apr 2020 13:26:43 +0200
Message-ID: <0d33b363-3801-8147-6f49-f1d6a845fdaf@redhat.com>
References: <20200414124304.4470-1-eesposit@redhat.com>
 <20200414124304.4470-3-eesposit@redhat.com>
 <7abfdd3b-dbbe-52ab-df53-95e9f86d39cd@linux.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587468413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wz4VbvB++wEfRs6vgYsKShIscVlUFGxxa9BcmRhqVZE=;
 b=bztazM9d7Ve3/nqCTE1J3qFDkuKV1zj5R+2Ut9MvPnPQtfTbyEdQijk/vRmCb4ka4/FQlz
 4dYuRfyU3H1z6L8PjMpk7U/SQVGwhR09h6Ol0gQuhkisiQxTCOiwDfOLduBTOk6DSEWKXi
 /ACK1PITnxToKTllyeT0whrmMkiKBso=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587468413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wz4VbvB++wEfRs6vgYsKShIscVlUFGxxa9BcmRhqVZE=;
 b=bztazM9d7Ve3/nqCTE1J3qFDkuKV1zj5R+2Ut9MvPnPQtfTbyEdQijk/vRmCb4ka4/FQlz
 4dYuRfyU3H1z6L8PjMpk7U/SQVGwhR09h6Ol0gQuhkisiQxTCOiwDfOLduBTOk6DSEWKXi
 /ACK1PITnxToKTllyeT0whrmMkiKBso=
In-Reply-To: <7abfdd3b-dbbe-52ab-df53-95e9f86d39cd@linux.ibm.com>
Content-Language: en-US
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: Frederic Barrat <fbarrat@linux.ibm.com>, linux-nfs@vger.kernel.org
Cc: Song Liu <songliubraving@fb.com>, linux-usb@vger.kernel.org, bpf@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@linux.ie>, Heiko Carstens <heiko.carstens@de.ibm.com>, Alexei Starovoitov <ast@kernel.org>, dri-devel@lists.freedesktop.org, "J. Bruce Fields" <bfields@fieldses.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, Hugh Dickins <hughd@google.com>, Paul Mackerras <paulus@samba.org>, John Johansen <john.johansen@canonical.com>, netdev@vger.kernel.org, linux-s390@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Andrew Donnellan <ajd@linux.ibm.com>, Matthew Garrett <matthew.garrett@nebula.com>, linux-efi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Daniel Borkmann <daniel@iogearbox.net>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-rdma@vger.kernel.org, Mark Fasheh <mark@fasheh.com>, Anton Vorontsov <anton@enomsg.org>, John



On 4/21/20 1:19 PM, Frederic Barrat wrote:
>=20
>=20
>> diff --git a/drivers/misc/cxl/Kconfig b/drivers/misc/cxl/Kconfig
>> index 39eec9031487..a62795079d9c 100644
>> --- a/drivers/misc/cxl/Kconfig
>> +++ b/drivers/misc/cxl/Kconfig
>> @@ -19,6 +19,7 @@ config CXL
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select CXL_BASE
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select CXL_AFU_DRIVER_OPS
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select CXL_LIB
>> +=C2=A0=C2=A0=C2=A0 select SIMPLEFS
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default m
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 help
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Select this option to enable =
driver support for IBM Coherent
>> diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
>> index b493de962153..0b8f8de7475a 100644
>> --- a/drivers/misc/cxl/api.c
>> +++ b/drivers/misc/cxl/api.c
>> @@ -9,6 +9,7 @@
>> =C2=A0 #include <misc/cxl.h>
>> =C2=A0 #include <linux/module.h>
>> =C2=A0 #include <linux/mount.h>
>> +#include <linux/simplefs.h>
>> =C2=A0 #include <linux/pseudo_fs.h>
>> =C2=A0 #include <linux/sched/mm.h>
>> =C2=A0 #include <linux/mmu_context.h>
>> diff --git a/drivers/misc/ocxl/Kconfig b/drivers/misc/ocxl/Kconfig
>> index 2d2266c1439e..ddd9245fff3d 100644
>> --- a/drivers/misc/ocxl/Kconfig
>> +++ b/drivers/misc/ocxl/Kconfig
>> @@ -12,6 +12,7 @@ config OCXL
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on PPC_POWERNV && PCI && EEH
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select OCXL_BASE
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select HOTPLUG_PCI_POWERNV
>> +=C2=A0=C2=A0=C2=A0 select SIMPLEFS
>=20
>=20
> It's not clear to me the Kconfig updated is needed for the ocxl driver.=
=20
> I think it's only needed for the cxl driver.

I am going to get rid of the separate simplefs.c file and related=20
Kconfig entry and put everything in fs/libfs.c, so this file (together=20
with many others touched in this patch) won't be modified in v2.

Thanks,

Emanuele

