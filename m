Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B50A8F40
	for <autofs@vger.kernel.org>; Tue,  7 Nov 2023 04:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N5ZYgr1R"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C57BED
	for <autofs@vger.kernel.org>; Mon,  6 Nov 2023 20:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699330652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OEClqip8Hd/4yw5LjGu4+pn6BbKEnTze4Tcl/EjSE1A=;
	b=N5ZYgr1RvD6+nk1TW9ABuB04fhS9qIlKFr9z3+AX7FTuGyDTxFam4DTiRYJEyQYnLJRjcI
	5Ed8WyojgKLAGHRX9r6oBsdVBX71GIN7obx361JkmomCqRdiYqrmlEc7HEWaztYVIr1PE2
	HciBTfvMDqpLfyepLAPbmmQlR/LEVF8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-7nIUO3X3NseDTuRK86SYOA-1; Mon, 06 Nov 2023 23:17:29 -0500
X-MC-Unique: 7nIUO3X3NseDTuRK86SYOA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-27ff8065e61so4515247a91.1
        for <autofs@vger.kernel.org>; Mon, 06 Nov 2023 20:17:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699330648; x=1699935448;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OEClqip8Hd/4yw5LjGu4+pn6BbKEnTze4Tcl/EjSE1A=;
        b=pbhDU8pX9acaSkqnrXAl5n2luTjplmIbeUkFUg8bOJwB9kiZ0jS3XlgjmBLfHWSkw1
         mwbCU+BA3lFY/hxbkGfLP/GVrInG70X3ZIekMlCqHD5vyuUhybhxkbJFF4v9O8+JDMHD
         dFOvgz+CBttRyAHjnPZWjWVTwOgR3JWqtPQ3+u5b0zh+Wr4zvQVDMmy/ONE+PMvn5qbQ
         h8jMKasLUEtULLDs1wA8Ij6Irh7TCTuog1VkQo1EYY5/py1A2MpCv1pSzGFsVQLASSvq
         jVBlJYcdMZSv/AamTsveDPdfNemQr4vMLGxBWsOZcMVCGaCp9jWlUgNCzarBKQEM/Ynp
         ln3A==
X-Gm-Message-State: AOJu0Yw8+dv6vlSIJcGgmYLPngZoJ5SawuvFpaENlaWlWbiQI2dNDvNH
	La+nJ9HQv28TPi1HOLX0zsh5/aprEhnHUoyJfZzI2qKOqRVVn4nqJGBfNFPB1EkxWcFlFIq8/e1
	VSlTWGGhU6zBo3bingBVdWof/AXqW7UBGewHLFU2nEGIdBl1lP/exAJ7eUs05riVrhfa8iOlS
X-Received: by 2002:a17:902:da87:b0:1cc:548d:4252 with SMTP id j7-20020a170902da8700b001cc548d4252mr27501634plx.57.1699330648036;
        Mon, 06 Nov 2023 20:17:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/bDSpYLFMGA8/IP0/ZDBgoerLMJpNRCRJpSAHrDXrDr7fFUbf3eUOwgyPRyBg+Ru2wXoVVg==
X-Received: by 2002:a17:902:da87:b0:1cc:548d:4252 with SMTP id j7-20020a170902da8700b001cc548d4252mr27501620plx.57.1699330647618;
        Mon, 06 Nov 2023 20:17:27 -0800 (PST)
Received: from [192.168.68.219] (159-196-82-144.9fc452.per.static.aussiebb.net. [159.196.82.144])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902f54400b001c898328289sm6636558plf.158.2023.11.06.20.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 20:17:27 -0800 (PST)
Message-ID: <26101f57-e5b3-e07b-c67f-259ab820cb0d@redhat.com>
Date: Tue, 7 Nov 2023 12:17:22 +0800
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: autofs mailing list <autofs@vger.kernel.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Ian Kent <ikent@redhat.com>
Subject: [ANNOUNCE] autofs 5.1.9 release
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

A release is long overdue so here it is, autofs-5.1.9.

There are quite a lot of changes in the release but they are mostly
bug fixes arising from a number significant improvements done over
the last several releases.

Some general performance overheads have crept in over quite a while
and work has been done to improve on it but once the obvious is done
it gets much harder to improve, so that's ongoing as time permits.

autofs
======

The package can be found at:
https://www.kernel.org/pub/linux/daemons/autofs/v5/

It is autofs-5.1.9.tar.[gz|xz]

No source rpm is there as it can be produced by using:

rpmbuild -ts autofs-5.1.9.tar.gz

and the binary rpm by using:

rpmbuild -tb autofs-5.1.9.tar.gz

Here are the entries from the CHANGELOG which outline the updates:

- fix kernel mount status notification.
- fix fedfs build flags.
- fix set open file limit.
- improve descriptor open error reporting.
- fix root offset error handling.
- fix fix root offset error handling.
- fix nonstrict fail handling of last offset mount.
- dont fail on duplicate offset entry tree add.
- fix loop under run in cache_get_offset_parent().
- bailout on rpc systemerror.
- fix nfsv4 only mounts should not use rpcbind.
- simplify cache_add() a little.
- fix use after free in tree_mapent_delete_offset_tree().
- fix memory leak in xdr_exports().
- avoid calling pthread_getspecific() with NULL key_thread_attempt_id.
- fix sysconf(3) return handling.
- remove nonstrict parameter from tree_mapent_umount_offsets().
- fix handling of incorrect return from umount_ent().
- dont use initgroups() at spawn.
- fix bashism in configure.
- musl: fix missing include in hash.h.
- musl: define fallback dummy NSS config path
- musl: avoid internal stat.h definitions.
- musl: add missing include to hash.h for _WORDSIZE.
- musl: add missing include to log.h for pid_t.
- musl: define _SWORD_TYPE.
- add autofs_strerror_r() helper for musl.
- update configure.
- handle innetgr() not present in musl.
- fix missing unlock in sasl_do_kinit_ext_cc().
- fix a couple of null cache locking problems.
- restore gcc flags after autoconf Kerberos 5 check.
- prepare for OpenLDAP SASL binding.
- let OpenLDAP handle SASL binding.
- configure: LDAP function checks ignore implicit declarations.
- improve debug logging of LDAP binds.
- improve debug logging of SASL binds.
- internal SASL logging only in debug log mode.
- more comprehensive verbose logging for LDAP maps.
- fix invalid tsv access.
- support SCRAM for SASL binding.
- ldap_sasl_interactive_bind() needs credentials for auto-detection.
- fix autofs regression due to positive_timeout.
- fix parse module instance mutex naming.
- serialise lookup module open and reinit.
- coverity fix for invalid access.
- fix hosts map deadlock on restart.
- fix deadlock with hosts map reload.
- fix memory leak in update_hosts_mounts().
- fix minus only option handling in concat_options().
- fix incorrect path for is_mounted() in try_remount().
- fix additional tsv invalid access.
- fix use_ignore_mount_option description.
- include addtional log info for mounts.
- fail on empty replicated host name.
- improve handling of ENOENT in sss setautomntent().
- don't immediately call function when waiting.
- define LDAP_DEPRECATED during LDAP configure check.
- fix return status of mount_autofs().
- don't close lookup at umount.
- fix deadlock in lookups.
- dont delay expire.
- make amd mapent search function name clear.
- rename statemachine() to signal_handler().
- make signal handling consistent.
- eliminate last remaining state_pipe usage.
- add function master_find_mapent_by_devid().
- use device id to locate autofs_point when setting log priotity.
- add command pipe handling functions.
- switch to application wide command pipe.
- get rid of unused field submnt_count.
- fix mount tree startup reconnect.
- fix unterminated read in handle_cmd_pipe_fifo_message().
- fix memory leak in sasl_do_kinit()
- fix fix mount tree startup reconnect.
- fix amd selector function matching.
- get rid entry thid field.
- continue expire immediately after submount check.
- eliminate realpath from mount of submount.
- eliminate root param from autofs mount and umount.
- remove redundant fstat from do_mount_direct().
- get rid of strlen call in handle_packet_missing_direct().
- remove redundant stat call in lookup_ghost().
- set mapent dev and ino before adding to index.
- change to use printf functions in amd parser.
- dont call umount_subtree_mounts() on parent at umount.
- dont take parent source lock at mount shutdown.
- fix possible use after free in handle_mounts_exit().
- make submount cleanup the same as top level mounts.
- add soucre parameter to module functions.
- add ioctlfd open helper.
- make open files limit configurable.
- use correct reference for IN6 macro call.
- dont probe interface that cant send packet.
- fix some sss error return cases.
- fix incorrect matching of cached wildcard key.
- fix expire retry looping.
- allow -null map in indirect maps.
- fix multi-mount check.
- fix let OpenLDAP handle SASL binding.
- always recreate credential cache.
- fix ldap_parse_page_control() check.
- fix typo in create_cmd_pipe_fifo().
- add null check in master_kill().
- be more careful with cmd pipe at exit.
- rename configure.in to configure.ac.
- update autoconf macros.
- update autoconf release.
- update autofs release.

Ian

