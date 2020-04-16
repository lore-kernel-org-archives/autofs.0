From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 0/8] Simplefs: group and simplify linux fs code
Date: Thu, 16 Apr 2020 06:59:22 +0000
Message-ID: <20200416065922.GS11244@42.do-not-panic.com>
References: <20200414124304.4470-1-eesposit@redhat.com>
Mime-Version: 1.0
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
Content-Disposition: inline
In-Reply-To: <20200414124304.4470-1-eesposit@redhat.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Emanuele Giuseppe Esposito <eesposit@redhat.com>
Cc: Song Liu <songliubraving@fb.com>, linux-usb@vger.kernel.org, bpf@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@linux.ie>, Heiko Carstens <heiko.carstens@de.ibm.com>, Alexei Starovoitov <ast@kernel.org>, dri-devel@lists.freedesktop.org, "J. Bruce Fields" <bfields@fieldses.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, Hugh Dickins <hughd@google.com>, Paul Mackerras <paulus@samba.org>, John Johansen <john.johansen@canonical.com>, netdev@vger.kernel.org, linux-s390@vger.kernel.org, ocfs2-devel@oss.oracle.com, Christoph Hellwig <hch@lst.de>, Andrew Donnellan <ajd@linux.ibm.com>, Matthew Garrett <matthew.garrett@nebula.com>, linux-efi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Daniel Borkmann <daniel@iogearbox.net>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-rdma@vger.kernel.org, Mark Fasheh <mark@fasheh.com>, Anton Vorontsov <>

On Tue, Apr 14, 2020 at 02:42:54PM +0200, Emanuele Giuseppe Esposito wrote:
> This series of patches introduce wrappers for functions,
> arguments simplification in functions calls and most importantly
> groups duplicated code in a single header, simplefs, to avoid redundancy
> in the linux fs, especially debugfs and tracefs.

The general goal seems worthy, but here I don't see explained why hasn't
this gone through libfs, and what the intention was long term. For
instance, you added some other generalizations which you have found. It
was not clear that this was the goal here, to expand on these paths.

What if common code on fs is found which are not part of debugfs and
tracefs, how does one decide if to move to libfs or simplefs?

  Luis
