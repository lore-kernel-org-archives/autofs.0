From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: [BUG] 5.0.0_beta1: infinite loop on read error
Date: Wed, 26 Sep 2007 11:05:14 +0100
Message-ID: <200709261105.14333.vda.linux@googlemail.com>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Hi Ian,

I was using automount 4.1.4 for many years now, and I run it like this:

automount -f -s -v --timeout 15 /.local/mnt/auto program /root/bin/mapper.sh

This is a valid syntax for 4.1.4, but 5.0.0 doesn't like it, and it doesn't
error out cleanly too.

It goes into infinite loop, eating 100% CPU and killable only with SIGKILL.
As it turns out, it opens /.local/mnt/auto and reads it, and gets EISDIR,
and ... retries, retries, retries forever. Here:

modules/lookup_file.c

        f = fopen(ctxt->mapname, "r");
 ...
        master_init_scan();
        while(1) {
                entry = read_one(f, path, ent);
                if (!entry) {
                        if (feof(f)) <===== doesnt check ferror()
                                break;
                        continue;
                }

Please fix.
--
vda
