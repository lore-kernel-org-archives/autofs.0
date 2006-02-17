From: Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC:PATCH 4/4] autofs4 - add new packet type for v5
 communications
Date: Fri, 17 Feb 2006 00:51:34 -0800
Message-ID: <20060217005134.6842f0ca.akpm@osdl.org>
References: <200602170701.k1H71Irp004035@eagle.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <200602170701.k1H71Irp004035@eagle.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org

Ian Kent <raven@themaw.net> wrote:
>
> +/* autofs v5 common packet struct */
>  +struct autofs_v5_packet {
>  +	struct autofs_packet_hdr hdr;
>  +	autofs_wqt_t wait_queue_token;
>  +	__u32 dev;
>  +	__u64 ino;
>  +	uid_t uid;
>  +	gid_t gid;
>  +	pid_t pid;
>  +	pid_t tgid;
>  +	int len;
>  +	char name[NAME_MAX+1];
>  +};

Is this known to work with 32-bit userspace on 64-bit kernels?

In particular, perhaps the ?id_t's should become a type of known size and
alignment (u32 or u64)?
