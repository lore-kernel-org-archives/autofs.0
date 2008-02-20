From: "Boucher, Frederic" <boucher@hp.com>
Subject: Linux issue
Date: Wed, 20 Feb 2008 09:46:50 +0000
Message-ID: <1CACFDBCCD7F494F8E6672A57C0E09E408B8C39B14@G1W0482.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Language: en-US
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
To: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

Hi,

That is my Autofs configuration on Suse sles9

cat /etc/auto.master
# $Id: auto.master,v 1.1 2001/04/17 11:43:02 arvin Exp arvin $
# Sample auto.master file
# Format of this file:
# mountpoint map options
# Also see variable AUTOFS_OPTIONS in /etc/sysconfig/autofs
# For details of the format look at autofs(8).

#/misc          /etc/auto.misc
/tmp_mnt/depot /etc/auto.direct_depot --timeout 300
/tmp_mnt/sapmnt/P10 /etc/auto.direct_sapmnt_P10 --timeout 0
/tmp_mnt/sapmnt/P01 /etc/auto.direct_sapmnt_P01 --timeout 0
/tmp_mnt/sapmnt/BP1 /etc/auto.direct_sapmnt_BP1 --timeout 0
/tmp_mnt/sapmnt/CP1 /etc/auto.direct_sapmnt_CP1 --timeout 0
/tmp_mnt/sapmnt/SP1 /etc/auto.direct_sapmnt_SP1 --timeout 0
/tmp_mnt/ixos/exchange /etc/auto.direct_ixos --timeout 300
/tmp_mnt/usr/sap /etc/auto.direct_trans --timeout 300

cat /etc/auto.direct_sapmnt_P10
global -rw coopp10:/export/sapmnt/P10/global
profile -rw coopp10:/export/sapmnt/P10/profile

cat /etc/auto.direct_trans
idoc_P01 -rw coopp01:/usr/sap/P01/idoc
common_P01 -rw coopp01:/export/usr/sap/common_P01
common_P10 -rw coopp10:/export/usr/sap/common_P10
common_BP1 -rw coopbp1:/export/usr/sap/common_BP1
common_CP1 -rw coopcp1:/export/usr/sap/common_CP1
#archive  -rw coopp01:/usr/sap/P01/archive
trans -rw coopp10:/export/usr/sap/trans
transbw -rw ca100t:/usr/sap/transbw
transcni -rw coopp01:/export/usr/sap/transcni
transcrm -rw coopcp1:/export/usr/sap/transcrm
transscm -rw coopsp1:/export/usr/sap/transscm
common_SP1 -rw coopsp1:/export/usr/sap/common_SP1

I found an issue, it occurs in case of any packages startup, if other package's IP is down, and some of the other packages nfs mounts are not umounted
In this case saposcol started by package is hanging (because commands like 'df' is hanging, because nfs of othe packages is not reachable), I tried differentes solution direct Map or not, proto=soft,bg, only bg or soft, nothing work, i use a workaround but that isn't the solution

Thanks to help me.

Frederic Boucher
Customer Support Engineer
