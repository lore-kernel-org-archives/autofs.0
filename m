Received: from mxout5.mail.janestreet.com (mxout5.mail.janestreet.com [64.215.233.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA6D2D47F6
	for <autofs@vger.kernel.org>; Mon, 15 Sep 2025 13:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.215.233.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757942499; cv=none; b=QMrel9iziVO5AepKKj8InsjAM8h4KVH84rEm95ME+SycbjZ49JNYjfX7VR3fzHcN4KLIh2V0w5XpEUdG76uC6yaY/KDKkBHARNV/+ujmM07QkmegO9Od1py67Tob29d7f/2TLEQzlyLTmquspcDk39Qyf2OkPMf2+QXs3VcfdXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757942499; c=relaxed/simple;
	bh=kzHErcYddenefB3rJ4Nc3j3LtbWzy6YtsWS0tAlh84Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kpdZZnw9c/wMU3MbQk3PooSFC8fzu6aPGFG/JvE1QxfsCCQDJM58d8YLt2G/k5r+gJ/ELcvasaqvQniDHgfQt3QAsCkfif8Gi9DjLJCGU/SGPDQnkxmSHlqvttQFNlV2GSajAi/LgJDsoFzAvFZrf3pEKGQ9xdhUX20HGSGHNwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com; spf=pass smtp.mailfrom=janestreet.com; dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=a1BtOqrm; arc=none smtp.client-ip=64.215.233.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=janestreet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="a1BtOqrm"
From: Jun Eeo <jeeo@janestreet.com>
To: raven@themaw.net
Cc: autofs@vger.kernel.org,
 	jeeo@janestreet.com
Subject: Helper for reproducing
Date: Mon, 15 Sep 2025 14:21:18 +0100
Message-ID: <20250915132136.3128316-1-jeeo@janestreet.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <922abdb7-659a-4663-af65-15e8415b87c8@themaw.net>
References: <922abdb7-659a-4663-af65-15e8415b87c8@themaw.net>
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janestreet.com;
  s=waixah; t=1757942497;
  bh=1H4CANDdO2l2x2cV5mBconhBcBPvfTWDcxaGyCLYLZ8=;
  h=From:To:Cc:Subject:Date:In-Reply-To:References;
  b=a1BtOqrm3Qcd+WrBCOCulHz47Jh6C0h/N1YyHTQ7f3m2J+P+bmpbqJLrSAayzBZmg
  7kuXzVOaZXjMvuPfF8/URwlS9MuFQWddLwt7072Vpu6KAdTDFp0W05EzvDvHDptM4O
  6GN5gDIuKxR8N26JHzie1k0U5e0NHXFxb0IkTaEMlT9t56GlL/wuXwALkxY0I51fUy
  0HSUT/97XT4bPyU8AzcIVArnmP33H0LNyRofHuVMarhqRpRPOHFN1Z8z4AbmgogQXX
  x4kPT1FUglKdplRo4/i0pEUW5w21JVmcEjKwu6VRMfbVzNvMAksVm7Y9hNpvlJ93A4
  lk+B5kjewbgYw==

(Apologies for the spam!)

One way to easily reproduce the issue is to run the autofs service
as a systemd unit (i.e. with the --systemd-service flag set), compile
this and add to LD_PRELOAD in the unit:

----8<----
#define _GNU_SOURCE
#include <dlfcn.h>
#include <stdio.h>
#include <stdlib.h>

int
sd_notify(int unset_environment, const char* state)
{
	fprintf(stderr, "sd_notify(%d, %s)\n", unset_environment, state);
	int (*fn)(int, const char*) = dlsym(RTLD_NEXT, "sd_notify");
	int rv = (*fn)(0, state);
	fprintf(stderr, "doing the unsetenv loop\n");
	if (unset_environment)
		while (1)
			unsetenv("NOTIFY_SOCKET");
	return rv;
}
---->8----

That helper just makes the unsetenv in sd_notify a bit more apparent:

----8<----
_public_ int sd_pid_notify_with_fds(
                pid_t pid,
                int unset_environment,
                const char *state,
                const int *fds,
                unsigned n_fds) {
        // bunch of work
finish:
        if (unset_environment)
                unsetenv("NOTIFY_SOCKET");

        return r;
}

// ...

_public_ int sd_notify(int unset_environment, const char *state) {
        return sd_pid_notify_with_fds(0, unset_environment, state, NULL, 0);
}
---->8----

At least in my version of glibc -- this produced the same coredump
deadlocks we were seeing in production. If you trigger an automount,
the systemd service should then look like:

    $ systemctl status autofs
    ● autofs.service - Automount daemon
       Loaded: loaded (/usr/lib/systemd/system/autofs.service; enabled; vendor preset: disabled)
       Active: active (running) since Mon 2025-09-15 13:07:30 BST; 31min ago
     Main PID: 3115468 (automount)
        Tasks: 15 (limit: 615964)
       Memory: 4.5M
       CGroup: /system.slice/autofs.service
               ├─3115468 /usr/sbin/automount --systemd-service --dont-check-daemon -n 1 -t 0 /tmp/my-config
               └─3115724 /usr/sbin/automount --systemd-service --dont-check-daemon -n 1 -t 0 /tmp/my-config

(i.e. the child process remains stuck forever). The stack trace in the
child process should then be something like:

(gdb) bt
#0  __lll_lock_wait_private () at ../sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:63
#1  0x00007f110f6505ce in __add_to_environ (name=0x55f89b8643c0 "autodir", value=0x55f89b8643e0 "/a",
    combined=0x0, replace=1) at setenv.c:133
#2  0x0000002600000025 in ?? ()
#3  0x00007f10df7fb4f0 in ?? ()
#4  0x00007f1110e10540 in ?? () at dl-open.c:200 from /lib64/ld-linux-x86-64.so.2
#5  0x00007f10df7fb460 in ?? ()
#6  0x0000000000000000 in ?? ()
