From: Emanuele Giuseppe Esposito <eesposit@redhat.com>
Subject: Re: [PATCH 0/8] Simplefs: group and simplify linux fs code
Date: Mon, 20 Apr 2020 16:01:08 +0200
Message-ID: <79e3dd06-7cea-7798-42a2-596c185abd7b@redhat.com>
References: <20200414124304.4470-1-eesposit@redhat.com>
 <20200416065922.GS11244@42.do-not-panic.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587391279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CRCdhBzjtov7RvcoLcOwUA5fYrO6qOb+mWbouXaiL5k=;
 b=HIpqY6r43kH/FzbD5R1+A5UZ+BgK28llVnveeeHeX2tXhDuGWJahaxx8nE2jQ2HscVo06u
 eFPiqlfnbb0CMKbCBPkbuNjRXAIT4KcPj7Y/j+AmBsOhu9xafYxZricmItF0y6lnUPKnjm
 b3rTskufbbHZHwOURsKs14cZW4bJhQI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587391279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CRCdhBzjtov7RvcoLcOwUA5fYrO6qOb+mWbouXaiL5k=;
 b=HIpqY6r43kH/FzbD5R1+A5UZ+BgK28llVnveeeHeX2tXhDuGWJahaxx8nE2jQ2HscVo06u
 eFPiqlfnbb0CMKbCBPkbuNjRXAIT4KcPj7Y/j+AmBsOhu9xafYxZricmItF0y6lnUPKnjm
 b3rTskufbbHZHwOURsKs14cZW4bJhQI=
In-Reply-To: <20200416065922.GS11244@42.do-not-panic.com>
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
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Song Liu <songliubraving@fb.com>, linux-usb@vger.kernel.org, bpf@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@linux.ie>, Heiko Carstens <heiko.carstens@de.ibm.com>, Alexei Starovoitov <ast@kernel.org>, dri-devel@lists.freedesktop.org, "J. Bruce Fields" <bfields@fieldses.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, Hugh Dickins <hughd@google.com>, Paul Mackerras <paulus@samba.org>, John Johansen <john.johansen@canonical.com>, netdev@vger.kernel.org, linux-s390@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Andrew Donnellan <ajd@linux.ibm.com>, Matthew Garrett <matthew.garrett@nebula.com>, linux-efi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Daniel Borkmann <daniel@iogearbox.net>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-rdma@vger.kernel.org, Mark Fasheh <mark@fasheh.com>, Anton Vorontsov <anton@enomsg.org>, John



On 4/16/20 8:59 AM, Luis Chamberlain wrote:
> On Tue, Apr 14, 2020 at 02:42:54PM +0200, Emanuele Giuseppe Esposito wrote:
>> This series of patches introduce wrappers for functions,
>> arguments simplification in functions calls and most importantly
>> groups duplicated code in a single header, simplefs, to avoid redundancy
>> in the linux fs, especially debugfs and tracefs.
> 
> The general goal seems worthy, but here I don't see explained why hasn't
> this gone through libfs, and what the intention was long term. For
> instance, you added some other generalizations which you have found. It
> was not clear that this was the goal here, to expand on these paths.
> 
> What if common code on fs is found which are not part of debugfs and
> tracefs, how does one decide if to move to libfs or simplefs?

The idea of simplefs (that I will also explain better in the cover 
letter and commit messages) is that not only it groups common code, but 
also introduces a new struct simple_fs that simplifies parameter 
passing. This means all fs that use these functions and the struct 
should include linux/simplefs.h, while all common functions that take a 
simple_fs struct will be added in simplefs.c

Thank you for all the feedback, I will incorporate it and send a new 
patch series soon.

Emanuele

