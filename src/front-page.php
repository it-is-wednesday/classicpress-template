<?php
function the_content_trimmed()
{
    $content = wp_trim_words(get_the_content(), 60, "...");
    $content = apply_filters("the_content", $content);
    $content = str_replace("]]>", "]]&gt;", $content);
    return $content;
}
get_header();
?>
<div>
    <?php if (have_posts()): ?>

    <?php if (is_home() && !is_front_page()): ?>
        <header>
            <h1 class="page-title screen-reader-text"><?php single_post_title(); ?></h1>
        </header>
    <?php endif; ?>

    <?php while (have_posts()): ?>
        <?php the_post(); ?>
        <a class="index-title" href="<?= get_post_permalink() ?>">
            <h1><?= get_the_title() ?></h1>
        </a>
        <?= the_content_trimmed() ?>
    <?php endwhile; ?>

    <?php // Previous/next page navigation.

        the_posts_pagination([
        "prev_text" => __("Previous page"),
        "next_text" => __("Next page"),
        "before_page_number" =>
            '<span class="meta-nav screen-reader-text">' .
            __("Page") .
            " </span>",
    ]); ?>

    <?php else: ?>
        <?php get_template_part("content", "none"); ?>
    <?php endif; ?>
</div>
<?php get_footer(); ?>
