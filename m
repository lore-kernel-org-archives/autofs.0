From: Leonardo Chiquitto <leonardo.lists@gmail.com>
Subject: Special map type "-hosts" no longer works
Date: Fri, 21 Mar 2014 10:17:14 -0300
Message-ID: <CAEySpB4QciPfW4Cck=jrtZ0ht1neig8re9DG0i1BZ7NOQsfU4w@mail.gmail.com>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=/kszX9o8cgX8c3WMuLy8ZCMO9WvfK4cpSAH1VhkcOJw=;
        b=Ttv6oWHlZCPT9TxRQ+aLL4iGCNGZ7Ra0wcy4SvKIoX2HnYb1ftWNLK24ahyU2dawF3
         6+imqB8r5ssaXaZhGpHE68w09n9maJvgJjhr5I4f6b8X4pcWg7nMuoDo0qNa7FxTc++h
         qYAQr4q/dFsrewIsFZKsZA+2ovZqHst4XMdD7mwhN0halSRcf0IJm6wXNb2Bpy2tWcdx
         ACnzP2b5bIS+XJj1kKbrN9zewb9oMbrdORhCJ2QNJRqULGUQPBpRnPPbOzKFTmlHPGtv
         WOnLOlS4y8rK3DfG8r2K5rnxJMcismLM817qH+vNl0WT+8g1RiTZV5+j1v8KGovdl/Zu
         iEiQ==
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs <autofs@vger.kernel.org>

Hi,

The last patches pushed to the git repository break the special -hosts
map:

automount[29770]: ghosting enabled
automount[29770]: master_do_mount: mounting /net
automount[29770]: automount_path_to_fifo: fifo name /run/autofs.fifo-net
automount[29770]: lookup_nss_read_map: reading map hosts (null)
automount[29770]: mount_autofs_indirect: failed to read map for /net
automount[29770]: handle_mounts: mount of /net failed!
automount[29770]: master_do_mount: failed to startup mount
systemd[1]: Started Automounts filesystems on demand.

> 518 int lookup_nss_read_map(struct autofs_point *ap, struct map_source *source, time_t age)
> 519 {
(...)
> 545                 if (map->type) {
> 546                         if (!strncmp(map->type, "multi", 5))
> 547                                 debug(ap->logopt, "reading multi map");
> 548                         else
> 549                                 debug(ap->logopt,
> 550                                       "reading map %s %s",
> 551                                        map->type, map->argv[0]);

=> Prints "reading map hosts (null)"

> 552                         result = lookup_map_read_map(ap, map, age);
> 553                         map = map->next;
> 554                         continue;
> 555                 }

Then lookup_map_read_map() will return NSS_STATUS_UNKNOWN because argv[0] is
NULL.

> 416 static int lookup_map_read_map(struct autofs_point *ap,
> 417                                struct map_source *map, time_t age)
> 418 {
> 419         char *path;
> 420
> 421         if (!map->argv[0])
> 422                 return NSS_STATUS_UNKNOWN;

The culprit is probably commit e40bff4fb ("fix map source with type lookup").

Leonardo
