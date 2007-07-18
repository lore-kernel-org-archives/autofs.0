From: Ian Kent <raven@themaw.net>
Subject: Re: Seeing some 5.0.1 stop expiring mounts
Date: Wed, 18 Jul 2007 14:46:07 +0800
Message-ID: <1184741167.4178.50.camel@raven.themaw.net>
References: <20070717195431.GA14624@cornholio.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20070717195431.GA14624@cornholio.qualcomm.com>
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
To: Mike Marion <mmarion@qualcomm.com>
Cc: autofs@linux.kernel.org

On Tue, 2007-07-17 at 12:54 -0700, Mike Marion wrote:
> autofs-5.0.1 with patches:
> 
> autofs-5.0.1-bad-cast.patch
> autofs-5.0.1-check-mtab-updated.patch
> autofs-5.0.1-check-user-info-return.patch
> autofs-5.0.1-cmd-global-options-fix.patch
> autofs-5.0.1-cmd-global-options.patch
> autofs-5.0.1-code-cleanups.patch
> autofs-5.0.1-conf-append-global.patch
> autofs-5.0.1-configure-cleanups.patch
> autofs-5.0.1-correct-hesiod-check.patch
> autofs-5.0.1-disable-exports-check.patch
> autofs-5.0.1-drop-default-prefix-from-config.patch
> autofs-5.0.1-export-check-network-fix-2.patch
> autofs-5.0.1-file-map-allow-white-space-only-line.patch
> autofs-5.0.1-fix-browse-dir-create.patch
> autofs-5.0.1-hosts-simple-fail.patch
> autofs-5.0.1-localfs-label-check.patch
> autofs-5.0.1-map-update-source-only.patch
> autofs-5.0.1-network_match-fix.patch
> autofs-5.0.1-null-domain-fix.patch
> autofs-5.0.1-random-selection.patch
> autofs-5.0.1-remove-macro-automount-8.patch
> autofs-5.0.1-remove-redundant-ident-macros.patch
> autofs-5.0.1-update-kernel-patches.patch

Might be worth considering going to 5.0.2, especially since you have a
busy site, as a nasty deadlock in the alarm handler has been fixed. 

There are patches for 5.0.1 on kernel.org as well.

Ian
