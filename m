From: Ronny Nilsson <rln-autofs@arbetsmyra.dyndns.org>
Subject: configure script bug --with-flagdir
Date: Sun, 31 Aug 2014 17:48:59 +0200
Message-ID: <201408311748.59806.rln-autofs@arbetsmyra.dyndns.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
Content-Disposition: inline
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs@vger.kernel.org

Hi
I would like to report a possible bug in the configure script. The 
option "--with-flagdir" doesn't seem to work. Studying the source it looks 
like the problem is a simple typo:
	filagdir="${withval}"
should probably be
	flagdir="${withval}"

I've tried both v5.0.9 and v5.1.0.

Thanks
/Ronny Nilsson

