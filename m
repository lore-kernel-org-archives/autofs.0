From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [autofs-4.1.1 patch] free of ap.path happens too early
 in cleanup
Date: Thu, 18 Mar 2004 09:55:24 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16473.47196.897192.145902@segfault.boston.redhat.com>
References: <16471.29962.851785.48804@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0403172217060.18212@raven.themaw.net>
	<16472.30279.850790.756677@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0403180915210.28728@wombat.indigo.net.au>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0403180915210.28728@wombat.indigo.net.au>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

==> Regarding Re: [autofs]  [autofs-4.1.1 patch] free of ap.path happens too early in cleanup; Ian Kent <raven@themaw.net> adds:

[snip]
raven> Hi Jeff,
>>
raven> I don't mind moving the free as you recommend (it looks OK) but,
raven> after a quick look, I can't see where ap.path is referred to out of
raven> context?
>> Sorry, I should have included more information.
>> 
>> Check for calls to umount_autofs(1), such as the call in handle_mounts:
>> 
>> if (map & LKP_FAIL) { if (map & LKP_INDIRECT) syslog(LOG_INFO, "bad map
>> format: found indirect, expected direct exiting"); else syslog(LOG_INFO,
>> "failed to load map, exiting"); rm_unwanted(ap.path, 1, 1);
>> umount_autofs(1); cleanup_exit(ap.path, 1);

raven> Ha! Developer blindness.

raven> Maybe you could look a bit closer and a bit further, yes.

Ugh.  Turns out I was actually looking at the 4.1.0 sources.  Terribly
sorry.

-Jeff

[from the 4.1.0 - 4.1.1 diff]

-                               cleanup_exit(ap.path, 1);
+                               cleanup_exit(path, 1);
