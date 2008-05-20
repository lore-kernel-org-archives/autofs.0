From: Ian Kent <raven@themaw.net>
Subject: Re: Kernel Patch to support nested bind mounts
Date: Tue, 20 May 2008 22:59:20 +0800
Message-ID: <1211295560.22177.55.camel@raven.themaw.net>
References: <1211293493.5073.17.camel@srss>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1211293493.5073.17.camel@srss>
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
To: Lukas Kolbe <lukas@einfachkaffee.de>
Cc: autofs@linux.kernel.org


On Tue, 2008-05-20 at 16:24 +0200, Lukas Kolbe wrote:
> Hi Ian, list,
> 
> this is just a ping to remind you of this little patch. It still applies
> to the latest kernel source, and it still fixes our problems we have
> with nested mount maps such as (taken from the map for /vol/):
> 
> 
> eclipse-3.2 \
>   /bin          -rw,nosuid          fileserver:/export/stud/vol/eclipse-3.2/bin/linx86 \
>   /include      -rw,nosuid          fileserver:/export/stud/vol/eclipse-3.2/include \
>   /lib          -rw,nosuid          fileserver:/export/stud/vol/eclipse-3.2/lib/linx86 \
>   /man          -rw,nosuid          fileserver:/export/stud/vol/eclipse-3.2/man \
>   /share        -rw,nosuid          fileserver:/export/stud/vol/eclipse-3.2/share
> 
> eclipse \
>   /bin          -rw,nosuid          :/vol/eclipse-3.2/bin \
>   /include      -rw,nosuid          :/vol/eclipse-3.2/include \
>   /lib          -rw,nosuid          :/vol/eclipse-3.2/lib \
>   /man          -rw,nosuid          :/vol/eclipse-3.2/man \
>   /share        -rw,nosuid          :/vol/eclipse-3.2/share \
> 
> and:
> 
> jdk             -rw,nosuid          :/vol/jdk-1.6
> jdk-1.6         -rw,nosuid          :/vol/jdk-1.6.6
> jdk-1.6.6       -rw,nosuid          fileserver:/export/stud/vol/jdk-1.6.6/linx86
> 
> 
> We're running this since quite a while, and have not encountered any
> serious problems since then. Home's and volumes get unmounted as they
> should, and (even more important) accessing /vol/jdk or /vol/eclipse/bin
> now actually works (it did _not_ without the patch).
> 
> I'm just tired of constantly rebuilding distribution kerneles :)

I thought the email replies to the kernel submission I made also went to
the autofs list. I didn't notice if that wasn't the case.

Anyway, Al Viro vetoed the patch with little justification except to say
that there are VFS changes coming that the patch won't fit well with,
but also didn't elaborate those changes when asked.

So all we can do is wait and see.

Ian
