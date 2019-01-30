From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/3] autofs: add ignore mount option
Date: Tue, 29 Jan 2019 17:16:22 -0800
Message-ID: <20190129171622.5b75f794d2b1e4d1055331eb@linux-foundation.org>
References: <154725122396.11260.16053424107144453867.stgit@pluto-themaw-net>
        <154725123970.11260.6113771566924907275.stgit@pluto-themaw-net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <154725123970.11260.6113771566924907275.stgit@pluto-themaw-net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Pan Bian <bianpan2016@163.com>

On Sat, 12 Jan 2019 08:00:40 +0800 Ian Kent <raven@themaw.net> wrote:

> Add an autofs file system mount option that can be used to provide
> a generic indicator to applications that the mount entry should be
> ignored when displaying mount information.

What is the reason for adding this feature?
