From: Frederic Barrat <fbarrat@linux.ibm.com>
Subject: Re: [PATCH 2/8] fs: extract simple_pin/release_fs to separate files
Date: Tue, 21 Apr 2020 13:19:45 +0200
Message-ID: <7abfdd3b-dbbe-52ab-df53-95e9f86d39cd@linux.ibm.com>
References: <20200414124304.4470-1-eesposit@redhat.com>
 <20200414124304.4470-3-eesposit@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
In-Reply-To: <20200414124304.4470-3-eesposit@redhat.com>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Emanuele Giuseppe Esposito <eesposit@redhat.com>, linux-nfs@vger.kernel.org
Cc: Song Liu <songliubraving@fb.com>, linux-usb@vger.kernel.org, bpf@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@linux.ie>, Heiko Carstens <heiko.carstens@de.ibm.com>, Alexei Starovoitov <ast@kernel.org>, dri-devel@lists.freedesktop.org, "J. Bruce Fields" <bfields@fieldses.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, Hugh Dickins <hughd@google.com>, Paul Mackerras <paulus@samba.org>, John Johansen <john.johansen@canonical.com>, netdev@vger.kernel.org, linux-s390@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Andrew Donnellan <ajd@linux.ibm.com>, Matthew Garrett <matthew.garrett@nebula.com>, linux-efi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Daniel Borkmann <daniel@iogearbox.net>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-rdma@vger.kernel.org, Mark Fasheh <mark@fasheh.com>, Anton Vorontsov <anton@enomsg.org>, John



> diff --git a/drivers/misc/cxl/Kconfig b/drivers/misc/cxl/Kconfig
> index 39eec9031487..a62795079d9c 100644
> --- a/drivers/misc/cxl/Kconfig
> +++ b/drivers/misc/cxl/Kconfig
> @@ -19,6 +19,7 @@ config CXL
>   	select CXL_BASE
>   	select CXL_AFU_DRIVER_OPS
>   	select CXL_LIB
> +	select SIMPLEFS
>   	default m
>   	help
>   	  Select this option to enable driver support for IBM Coherent
> diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
> index b493de962153..0b8f8de7475a 100644
> --- a/drivers/misc/cxl/api.c
> +++ b/drivers/misc/cxl/api.c
> @@ -9,6 +9,7 @@
>   #include <misc/cxl.h>
>   #include <linux/module.h>
>   #include <linux/mount.h>
> +#include <linux/simplefs.h>
>   #include <linux/pseudo_fs.h>
>   #include <linux/sched/mm.h>
>   #include <linux/mmu_context.h>
> diff --git a/drivers/misc/ocxl/Kconfig b/drivers/misc/ocxl/Kconfig
> index 2d2266c1439e..ddd9245fff3d 100644
> --- a/drivers/misc/ocxl/Kconfig
> +++ b/drivers/misc/ocxl/Kconfig
> @@ -12,6 +12,7 @@ config OCXL
>   	depends on PPC_POWERNV && PCI && EEH
>   	select OCXL_BASE
>   	select HOTPLUG_PCI_POWERNV
> +	select SIMPLEFS


It's not clear to me the Kconfig updated is needed for the ocxl driver. 
I think it's only needed for the cxl driver.

   Fred

