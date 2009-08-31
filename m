From: "Jason T. Masker" <jason.fmic@masker.net>
Subject: Re: More CIFS $ Share Woes
Date: Mon, 31 Aug 2009 16:34:34 -0400
Message-ID: <85c7eb2d0908311334t486a7b2aq6b0be673a21d514d@mail.gmail.com>
References: <85c7eb2d0908280709u35cd5cfci7f50413da61539e7@mail.gmail.com>
	<4A9B5274.4040800@themaw.net>
	<85c7eb2d0908310522u18907b17pd1399a1cf79ad1e5@mail.gmail.com>
	<85c7eb2d0908311255j5b457221ld88131f111611f04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <85c7eb2d0908311255j5b457221ld88131f111611f04@mail.gmail.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
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

I have confirmed that what automount reports it is passing in the
debug output is not actually being passed to mount.cifs.  Observe the
following cifs debug when the process fails:


 fs/cifs/cifsfs.c: Devname: //VMW1013/C/$ flags: 64
 fs/cifs/connect.c: CIFS VFS: in cifs_mount as Xid: 2513 with uid: 0
 fs/cifs/connect.c: prefix path /$
 fs/cifs/connect.c: Username: jmasker
 fs/cifs/connect.c: UNC: \\VMW1013\C ip: 10.0.33.12
 fs/cifs/connect.c: Socket created
 fs/cifs/connect.c: sndbuf 16384 rcvbuf 87380 rcvtimeo 0x1b58
 fs/cifs/connect.c: Existing smb sess not found
 fs/cifs/cifssmb.c: secFlags 0x7
 fs/cifs/transport.c: For smb_command 114
 fs/cifs/transport.c: Sending smb:  total_len 82
 fs/cifs/connect.c: Demultiplex PID: 23495
 fs/cifs/connect.c: rfc1002 length 0x69
 fs/cifs/cifssmb.c: Dialect: 2
 fs/cifs/cifssmb.c: negprot rc 0
 fs/cifs/connect.c: Security Mode: 0x3 Capabilities: 0xe3fd
TimeAdjust: 14400
 fs/cifs/sess.c: sess setup type 2
 fs/cifs/transport.c: For smb_command 115
 fs/cifs/transport.c: Sending smb:  total_len 278
 fs/cifs/connect.c: rfc1002 length 0x7f
 fs/cifs/misc.c: Null buffer passed to cifs_small_buf_release
 fs/cifs/sess.c: ssetup rc from sendrecv2 is 0
 fs/cifs/sess.c: UID = 2048
 fs/cifs/sess.c: bleft 81
 fs/cifs/sess.c: words left: 0
 fs/cifs/sess.c: ssetup freeing small buf f4d06700
 fs/cifs/connect.c: CIFS Session Established successfully
 fs/cifs/connect.c: file mode: 0x1a4  dir mode: 0x1ed
 fs/cifs/transport.c: For smb_command 117
 fs/cifs/transport.c: Sending smb:  total_len 78
 fs/cifs/connect.c: rfc1002 length 0x27
Status code returned 0xc00000cc NT_STATUS_BAD_NETWORK_NAME
 fs/cifs/netmisc.c: Mapping smb error code 67 to POSIX err -6
 fs/cifs/connect.c: CIFS Tcon rc = -6
 fs/cifs/connect.c: CIFS VFS: in cifs_put_tcon as Xid: 2514 with uid:
0
 fs/cifs/cifssmb.c: In tree disconnect
 fs/cifs/transport.c: For smb_command 113
 fs/cifs/transport.c: Sending smb:  total_len 39
 fs/cifs/connect.c: rfc1002 length 0x27
 fs/cifs/netmisc.c: Mapping smb error code 5 to POSIX err -6
 fs/cifs/cifssmb.c: Tree disconnect failed -6
 fs/cifs/connect.c: CIFS VFS: in cifs_put_smb_ses as Xid: 2515 with
uid: 0
 fs/cifs/cifssmb.c: In SMBLogoff for session disconnect
 fs/cifs/transport.c: For smb_command 116
 fs/cifs/transport.c: Sending smb:  total_len 43
 fs/cifs/connect.c: rfc1002 length 0x2b
 fs/cifs/connect.c: CIFS VFS: leaving cifs_mount (xid = 2513) rc = -6
 CIFS VFS: cifs_mount failed w/return code = -6




Notice the Devname is mangled to //VMW1013/C/$ ..   Here is the output
when I copy the mount command out of the automount debug and paste it
into bash verbatim:


 fs/cifs/cifsfs.c: Devname: //VMW1013/C$ flags: 64
 fs/cifs/connect.c: CIFS VFS: in cifs_mount as Xid: 2516 with uid: 0
 fs/cifs/connect.c: Domain name set
 fs/cifs/connect.c: Username: jmasker
 fs/cifs/connect.c: UNC: \\VMW1013\C$ ip: 10.0.33.12
 fs/cifs/connect.c: Socket created
 fs/cifs/connect.c: sndbuf 16384 rcvbuf 87380 rcvtimeo 0x1b58
 fs/cifs/connect.c: Existing smb sess not found
 fs/cifs/cifssmb.c: secFlags 0x7
 fs/cifs/transport.c: For smb_command 114
 fs/cifs/connect.c: Demultiplex PID: 23551
 fs/cifs/transport.c: Sending smb:  total_len 82
 fs/cifs/connect.c: rfc1002 length 0x69
 fs/cifs/cifssmb.c: Dialect: 2
 fs/cifs/cifssmb.c: negprot rc 0
 fs/cifs/connect.c: Security Mode: 0x3 Capabilities: 0xe3fd
TimeAdjust: 14400
 fs/cifs/sess.c: sess setup type 2
 fs/cifs/transport.c: For smb_command 115
 fs/cifs/transport.c: Sending smb:  total_len 284
 fs/cifs/connect.c: rfc1002 length 0x7f
 fs/cifs/misc.c: Null buffer passed to cifs_small_buf_release
 fs/cifs/sess.c: ssetup rc from sendrecv2 is 0
 fs/cifs/sess.c: UID = 2048
 fs/cifs/sess.c: bleft 81
 fs/cifs/sess.c: words left: 0
 fs/cifs/sess.c: ssetup freeing small buf de836700
 fs/cifs/connect.c: CIFS Session Established successfully
