From: "Gordon Lack" <gml4410@ggr.co.uk>
Subject: Bug in autofs v4.1.4 init.d script (and fix)
Date: Fri, 08 Sep 2006 12:31:37 +0100
Message-ID: <45015498.22A9C700@ggr.co.uk>
References: <44AE7785.74E63D70@ggr.co.uk> <44EB1231.7ABAA89B@ggr.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
To: autofs@linux.kernel.org

   In the getfilemounts() function when the code comes acros a line
which starts with a "+" (include an NIS map here) instead of just
including that map it cats the entire /etc/auto.master file again and
actually include *all* NIS maps which are mentioned.  This means that if
you have n (> 1) NIS map inclusions then the inclusions are done <n>
times,and it also means that the inclusion for all maps is first done
when the first NIS map inclusion is found. 

   It is perfectly legitimate to have an /etc/auto.master file like
this:

+auto.master-TEST
/home   /etc/my-home-override.amap
+auto.master

   whereby the /home setting is meant to override the stanmdrad one in
auto.master.  The bug in the getfilemounts() function stops this
happening as auto.master will be included when +auto.master-TEST is
seen.

   The fix for this is to change the "while read auto_master_in" loop to
be:

        while read auto_master_in
        do
            case "$auto_master_in" in
            +*)
                nismap=`echo $auto_master_in | sed -e 's/^\+//'`
                catnismap $nismap
                ;;
            *)
                echo $auto_master_in
                ;;
            esac
        done
