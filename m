From: David Meleedy <david.meleedy@analog.com>
Subject: Re: BUG: autofs4 + cd /net/<Netapp>/vol/vol[0-3] = port 
	usage problems
Date: Wed, 12 Jan 2005 15:43:52 -0500
Message-ID: <200501122043.j0CKhqY2011152@jetcar.spd.analog.com>
References: <41E55688.9070107@sun.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: Your message of "Wed, 12 Jan 2005 11:55:36 EST."
	<41E55688.9070107@sun.com> 
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Waychison <Michael.Waychison@sun.com>
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>


> Out of curiosity, can we see the output of showmount -e against your filer?

codered-51: showmount -e aflac
Export list for aflac:
/vol/vol2/9xcores         (everyone)
/vol/vol2/gpdsp_marketing (everyone)
/vol/vol1/thor            (everyone)
/vol/vol1/admin           (everyone)
/vol/vol3/is_013std       (everyone)
/vol/vol1/pe_workspace    (everyone)
/vol/vol1                 (everyone)
/vol/vol2/spitfire        (everyone)
/vol/vol3/layout_old      (everyone)
/vol/vol1/jordan          (everyone)
/vol/vol2/DSPS_Finance    (everyone)
/vol/vol2/sh              (everyone)
/vol/vol2/gpdsp_PLD       (everyone)
/vol/vol1/tigersharc      (everyone)
/vol/vol1/ed              (everyone)
/vol/vol3/ta              (everyone)
/vol/vol2                 (everyone)
/vol/vol2/pc_backups      (everyone)
/vol/vol2/india_mirror    (everyone)
/vol/vol2/ulc3            (everyone)
/vol/vol1/is_013std       (everyone)
/vol/vol3/lx3             (everyone)
/vol/vol2/danube          (everyone)
/vol/vol3                 (everyone)
/vol/vol1/teton_lite      (everyone)
/vol/vol3/emerald         (everyone)
/vol/vol3/archive         (everyone)
/vol/vol1/diablo          (everyone)
/vol/vol2/nwd_testmgr     (everyone)
/vol/vol1/ras             (everyone)
/vol/vol1/soft            (everyone)
/vol/vol2/nile            (everyone)
/vol/vol2/bluetooth       (everyone)
/vol/vol3/ad1983          (everyone)
/vol/vol1/IssueManager    (everyone)
/vol/vol3/cad_archive     (everyone)
/vol/vol2/win2k           (everyone)
/vol/vol2/nwd_layout      (everyone)
/vol/vol1/cpd             (everyone)
/vol/vol3/design          (everyone)
/vol/vol1/herc_eval       (everyone)
/vol/vol0                 (everyone)
/vol/vol2/bitpower        (everyone)
/vol/vol1/fsp             (everyone)
/vol/vol1/archive         (everyone)


codered-52: /etc/auto.net aflac
-fstype=nfs,hard,intr,nodev,nosuid \
        /vol/vol0 aflac:/vol/vol0 \
        /vol/vol1/admin aflac:/vol/vol1/admin \
        /vol/vol1/archive aflac:/vol/vol1/archive \
        /vol/vol1/cpd aflac:/vol/vol1/cpd \
        /vol/vol1/diablo aflac:/vol/vol1/diablo \
        /vol/vol1/ed aflac:/vol/vol1/ed \
        /vol/vol1 aflac:/vol/vol1 \
        /vol/vol1/fsp aflac:/vol/vol1/fsp \
        /vol/vol1/herc_eval aflac:/vol/vol1/herc_eval \
        /vol/vol1/is_013std aflac:/vol/vol1/is_013std \
        /vol/vol1/IssueManager aflac:/vol/vol1/IssueManager \
        /vol/vol1/jordan aflac:/vol/vol1/jordan \
        /vol/vol1/pe_workspace aflac:/vol/vol1/pe_workspace \
        /vol/vol1/ras aflac:/vol/vol1/ras \
        /vol/vol1/soft aflac:/vol/vol1/soft \
        /vol/vol1/teton_lite aflac:/vol/vol1/teton_lite \
        /vol/vol1/thor aflac:/vol/vol1/thor \
        /vol/vol1/tigersharc aflac:/vol/vol1/tigersharc \
        /vol/vol2/9xcores aflac:/vol/vol2/9xcores \
        /vol/vol2/bitpower aflac:/vol/vol2/bitpower \
        /vol/vol2/bluetooth aflac:/vol/vol2/bluetooth \
        /vol/vol2/danube aflac:/vol/vol2/danube \
        /vol/vol2/DSPS_Finance aflac:/vol/vol2/DSPS_Finance \
        /vol/vol2 aflac:/vol/vol2 \
        /vol/vol2/gpdsp_marketing aflac:/vol/vol2/gpdsp_marketing \
        /vol/vol2/gpdsp_PLD aflac:/vol/vol2/gpdsp_PLD \
        /vol/vol2/india_mirror aflac:/vol/vol2/india_mirror \
        /vol/vol2/nile aflac:/vol/vol2/nile \
        /vol/vol2/nwd_layout aflac:/vol/vol2/nwd_layout \
        /vol/vol2/nwd_testmgr aflac:/vol/vol2/nwd_testmgr \
        /vol/vol2/pc_backups aflac:/vol/vol2/pc_backups \
        /vol/vol2/sh aflac:/vol/vol2/sh \
        /vol/vol2/spitfire aflac:/vol/vol2/spitfire \
        /vol/vol2/ulc3 aflac:/vol/vol2/ulc3 \
        /vol/vol2/win2k aflac:/vol/vol2/win2k \
        /vol/vol3/ad1983 aflac:/vol/vol3/ad1983 \
        /vol/vol3/archive aflac:/vol/vol3/archive \
        /vol/vol3/cad_archive aflac:/vol/vol3/cad_archive \
        /vol/vol3/design aflac:/vol/vol3/design \
        /vol/vol3/emerald aflac:/vol/vol3/emerald \
        /vol/vol3 aflac:/vol/vol3 \
        /vol/vol3/is_013std aflac:/vol/vol3/is_013std \
        /vol/vol3/layout_old aflac:/vol/vol3/layout_old \
        /vol/vol3/lx3 aflac:/vol/vol3/lx3 \
        /vol/vol3/ta aflac:/vol/vol3/ta


________________________________________________________________________
David Meleedy				Analog Devices, Inc.
David.Meleedy@analog.com		Three Technology Way
Phone: 781 461 3494			Norwood, MA  02062-9106  USA
