From: Mike Marion <mmarion@qualcomm.com>
Subject: Seeing some 5.0.1 stop expiring mounts
Date: Tue, 17 Jul 2007 12:54:31 -0700
Message-ID: <20070717195431.GA14624@cornholio.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
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

autofs-5.0.1 with patches:

autofs-5.0.1-bad-cast.patch
autofs-5.0.1-check-mtab-updated.patch
autofs-5.0.1-check-user-info-return.patch
autofs-5.0.1-cmd-global-options-fix.patch
autofs-5.0.1-cmd-global-options.patch
autofs-5.0.1-code-cleanups.patch
autofs-5.0.1-conf-append-global.patch
autofs-5.0.1-configure-cleanups.patch
autofs-5.0.1-correct-hesiod-check.patch
autofs-5.0.1-disable-exports-check.patch
autofs-5.0.1-drop-default-prefix-from-config.patch
autofs-5.0.1-export-check-network-fix-2.patch
autofs-5.0.1-file-map-allow-white-space-only-line.patch
autofs-5.0.1-fix-browse-dir-create.patch
autofs-5.0.1-hosts-simple-fail.patch
autofs-5.0.1-localfs-label-check.patch
autofs-5.0.1-map-update-source-only.patch
autofs-5.0.1-network_match-fix.patch
autofs-5.0.1-null-domain-fix.patch
autofs-5.0.1-random-selection.patch
autofs-5.0.1-remove-macro-automount-8.patch
autofs-5.0.1-remove-redundant-ident-macros.patch
autofs-5.0.1-update-kernel-patches.patch

kernel 2.6.16.21-0.9 on sles9-sp3 (took sles10 kernel src.rpm and built
new kernel on top of sles9).

All maps in LDAP.  Startup is fine... 6200+ entries in /proc/mounts (Yes
we have that many).  Some hosts get into a state where they aren't
expiring mounts anymore:
$ mount -t nfs | wc
    476    2856   70188

Differences I see in ps are that there's another thread hanging around
(wedged?):
ps axsm output:
    0  2840 0000000000010201                -                -
- -    ?        384:58 automoun    0     - 0000000000000000
  fffffffe7ffbfeff 0000000000000000 0000000180000000 Tsl  -
0:00 -
    0     - 0000000000000000 fffffffe7ffbfeff 0000000000000000
0000000180000000 Ssl  -          0:00 -
    0     - 0000000000000000 fffffffe7ffbfeff 0000000000000000
0000000180000000 Ssl  -          0:16 -
    0     - 0000000000000000 fffffffe7ffbfeff 0000000000000000
0000000180000000 Ssl  -          0:04 -
    0     - 0000000000000000 fffffffe7ffbfeff 0000000000000000
0000000180000000 Ssl  -          0:10 -
    0     - 0000000000000000 fffffffe7ffbfeff 0000000000000000
0000000180000000 Ssl  -          0:09 -
    0     - 0000000000000000 fffffffe7ffbfeff 0000000000000000
0000000180000000 Ssl  -          0:00 -
    0     - 0000000000000000 fffffffe7ffbfeff 0000000000000000
0000000180000000 Ssl  -          0:00 -
    0     - 0000000000000000 fffffffe7ffbfeff 0000000000000000
0000000180000000 Ssl  -          0:02 -

ps -eLF output:
root      2840     1  2840  0    9 15576  7208   2 Jul05 ?
00:00:00 automount
root      2840     1  2841  0    9 15576  7208   2 Jul05 ?
00:00:00 automount
root      2840     1  2842  0    9 15576  7208   2 Jul05 ?
00:00:16 automount
root      2840     1  2845  0    9 15576  7208   1 Jul05 ?
00:00:04 automount
root      2840     1  2848  0    9 15576  7208   0 Jul05 ?
00:00:10 automount
root      2840     1  2849  0    9 15576  7208   3 Jul05 ?
00:00:09 automount
root      2840     1 32417  0    9 15576  7208   2 Jul13 ?
00:00:00 automount
root      2840     1  2230  0    9 15576  7208   3 Jul14 ?
00:00:00 automount
root      2840     1  2235  0    9 15576  7208   1 Jul14 ?
00:00:02 automount

Hosts that are ok spawn a new thread periodically, the wedged hosts
don't.  Kill -USR1/HUP don't seem to have any effect, even stracing
process while sending that signal shows that it never seems to see it
(no SIGUSR1 info in strace).  

Strace shows host stuck doing nothing but futex and time calls like
this:
[pid  2840] futex(0x555555685ac4, FUTEX_WAIT, 2949131, {0, 993887000}) =
-1 ETIMEDOUT (Connection timed out)
[pid  2840] futex(0x555555685a80, FUTEX_WAKE, 1) = 0
[pid  2840] clock_gettime(CLOCK_REALTIME, {1184701903, 6010000}) = 0
[pid  2840] futex(0x555555685ac4, FUTEX_WAIT, 2949133, {0, 993990000}) =
-1 ETIMEDOUT (Connection timed out)
[pid  2840] futex(0x555555685a80, FUTEX_WAKE, 1) = 0
[pid  2840] clock_gettime(CLOCK_REALTIME, {1184701904, 5912000}) = 0
[pid  2840] futex(0x555555685ac4, FUTEX_WAIT, 2949135, {0, 994088000}) =
-1 ETIMEDOUT (Connection timed out)
[pid  2840] futex(0x555555685a80, FUTEX_WAKE, 1) = 0
[pid  2840] clock_gettime(CLOCK_REALTIME, {1184701905, 5758000}) = 0
[pid  2840] futex(0x555555685ac4, FUTEX_WAIT, 2949137, {0, 994242000}) =
-1 ETIMEDOUT (Connection timed out)
[pid  2840] futex(0x555555685a80, FUTEX_WAKE, 1) = 0
[pid  2840] clock_gettime(CLOCK_REALTIME, {1184701906, 5657000}) = 0
[pid  2840] futex(0x555555685ac4, FUTEX_WAIT, 2949139, {0, 994343000}) =
-1 ETIMEDOUT (Connection timed out)
[pid  2840] futex(0x555555685a80, FUTEX_WAKE, 1) = 0
[pid  2840] clock_gettime(CLOCK_REALTIME, {1184701907, 5625000}) = 0
[pid  2840] futex(0x555555685ac4, FUTEX_WAIT, 2949141, {0, 994375000}) =
-1 ETIMEDOUT (Connection timed out)
[pid  2840] futex(0x555555685a80, FUTEX_WAKE, 1) = 0
[pid  2840] clock_gettime(CLOCK_REALTIME, {1184701908, 5506000}) = 0
[pid  2840] futex(0x555555685ac4, FUTEX_WAIT, 2949143, {0, 994494000}) =
-1 ETIMEDOUT (Connection timed out)
[pid  2840] futex(0x555555685a80, FUTEX_WAKE, 1) = 0
[pid  2840] clock_gettime(CLOCK_REALTIME, {1184701909, 5422000}) = 0


Wondering if anyone else has seen and/or has any idea what might be the
cause.

-- 
Mike Marion-Unix SysAdmin/Staff IT Engineer-http://www.qualcomm.com
"I've never used their tech support, but the word is that it sucks."
I believe it's composed entirely of monkeys that couldn't get the Shakespeare
gig. :-) ==> /. users talking about @home tech support
